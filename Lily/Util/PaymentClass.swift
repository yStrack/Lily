import PassKit
import Stripe

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
    // MARK:- Atributos
    static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .masterCard,
        .visa,
        .maestro,
        .elo
    ]
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    var totalAmount:NSDecimalNumber?
    
    // MARK:- Funções
    private func createCartSummaryItems(items:[Item]) -> [PKPaymentSummaryItem]{
        var totalPrice : Double = 0.0
        for item in items{
            let itemSummary = PKPaymentSummaryItem(label: String(item.name[item.name.startIndex..<(item.name.firstIndex(of: "|") ?? item.name.endIndex)]) + "(x\(Cart.instance.getAmount(item: item)))", amount: NSDecimalNumber(value: item.price * Double(Cart.instance.getAmount(item: item))), type: .final)
            paymentSummaryItems.append(itemSummary)
            totalPrice += Double(truncating: itemSummary.amount)
        }
        let tax = PKPaymentSummaryItem(label: "Frete", amount: NSDecimalNumber(string: "11.00"), type: .final)
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: totalPrice + 11), type: .final)
        totalAmount = NSDecimalNumber(value: (totalPrice + 11)*100)
        paymentSummaryItems.append(tax)
        paymentSummaryItems.append(total)
        return paymentSummaryItems
    }
    
    func startCartPayment(items: [Item], completion: @escaping PaymentCompletionHandler){
        paymentSummaryItems = createCartSummaryItems(items: items)
        completionHandler = completion
        setupPayment(paymentSummaryItems: paymentSummaryItems)
    }
    
    func startClipPayment(item: Item, completion: @escaping PaymentCompletionHandler) {
        // Item a ser comprado
        // Aqui há uma lógica para cortar parte do nome do produto a fim de tornar a interface mais amigável
        let itemLabel = String(item.name[item.name.startIndex..<(item.name.firstIndex(of: "|") ?? item.name.endIndex)])
        let itemDetail = PKPaymentSummaryItem(label: itemLabel , amount: NSDecimalNumber(value: item.price), type: .final)
        
        // Frete da encomenda
        let shipping = PKPaymentSummaryItem(label: "Frete", amount: NSDecimalNumber(string: "11.00"), type: .final)
        
        // Valor total a ser pago
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: item.price + 11), type: .final)
        
        // Variável que recebe o valor total para a proxima parte do processamento de pagamentos
        totalAmount = NSDecimalNumber(value: (item.price + 11) * 100)
        // Montagem da lista de itens
        paymentSummaryItems = [itemDetail, shipping, total];
        completionHandler = completion
        // Chamando a função responsável por criar a nossa requisição de pagamento
        setupPayment(paymentSummaryItems: paymentSummaryItems)
    }
    
    private func setupPayment(paymentSummaryItems: [PKPaymentSummaryItem]){
        let paymentRequest = PKPaymentRequest()
        // Itens que serão comprados
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        // Merchant identifier criado no portal do Apple Developer
        paymentRequest.merchantIdentifier = "merchant.com.pany.lily"
        // Suporte para o protocole de segurança 3-D
        paymentRequest.merchantCapabilities = .capability3DS
        // Código do país onde a compra está sendo efetuada (ISO-3166)
        paymentRequest.countryCode = "BR"
        // Código da moeda da transação (ISO-4217)
        paymentRequest.currencyCode = "BRL"
        // Informações requeridas a serem preenchidas na tela de pagamento
        paymentRequest.requiredShippingContactFields = [.phoneNumber, .emailAddress, .postalAddress]
        // Informações sobre as bandeiras aceitas previamente definidas
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        
        // Exibir a tela de pagamaento
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                print("Presented payment controller")
            } else {
                print("Failed to present payment controller")
                self.completionHandler!(false)
            }
        })
    }
}

/*
 PKPaymentAuthorizationControllerDelegate conformance.
 */
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        // Troque a string pela sua chave pública de teste fornecida pelo Stripe
        StripeAPI.defaultPublishableKey = "YOUR_STRIPE_PUBLISHABLE_KEY"
        
        // Conectando com a API do Stripe
        STPAPIClient.shared.createSource(with: payment) {
            (token, error) -> Void in
            
            if (error != nil) {
                completion(PKPaymentAuthorizationStatus.failure)
                return
            }
            
            // URL do servidor rodando localmente
            let url = URL(string: "http://127.0.0.1:5000/pay")
            
            // Criando requisição
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            // Metadados da compra que queremos receber
            var metadata:[String:NSDecimalNumber] = [:]
            for el in self.paymentSummaryItems{
                metadata[el.label] = el.amount
            }
            
            let name = payment.shippingContact!.name!.givenName! + " " + payment.shippingContact!.name!.familyName!
            
            // Corpo da requisição com as chaves que colocamos no servidor Python
            let body:[String : Any] = ["stripeToken": token!.stripeID,
                                       "amount": self.totalAmount!,
                                       "description": payment.description,
                                       "shipping": [
                                        "address": [
                                            "line1":payment.shippingContact?.postalAddress?.street,
                                            "city": payment.shippingContact?.postalAddress?.city,
                                            "country": payment.shippingContact?.postalAddress?.country,
                                            "line2": payment.shippingContact?.postalAddress?.subLocality,
                                            "postal_code": payment.shippingContact?.postalAddress?.postalCode,
                                            "state": payment.shippingContact?.postalAddress?.state,
                                        ],
                                        "name": name,
                                       ],
                                       "metadata": metadata
            ]
            
            //Transformando a requisição em um JSON
            request.httpBody = try! JSONSerialization.data(withJSONObject: body)
            
            // Enviando a requisição para o nosso servidor Python
            URLSession.shared.dataTask(with: request){ (response, data, error) in
                if (error != nil) {
                    self.paymentStatus = PKPaymentAuthorizationStatus.failure
                } else {
                    self.paymentStatus = PKPaymentAuthorizationStatus.success
                }
                
                // Retorna se o pagamento foi concluido com sucesso ou não pelo Stripe para a tela do Apple Pay
                DispatchQueue.main.async {
                    completion(self.paymentStatus)
                }
            }.resume()
        }
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true)
                } else {
                    self.completionHandler!(false)
                }
                self.paymentSummaryItems.removeAll()
            }
        }
    }
    
}
