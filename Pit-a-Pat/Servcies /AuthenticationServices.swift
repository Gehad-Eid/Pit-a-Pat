import AuthenticationServices

class AuthenticationManager: NSObject, ObservableObject {
    @Published var isAuthenticated: Bool = false

    func handleSignInWithApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AuthenticationManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // تم بنجاح تسجيل الدخول باستخدام Apple ID
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // استخدم معلومات الاعتماد هنا
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            // يمكنك معالجة معلومات الاعتماد هنا
            print("User ID: \(userIdentifier)")
            print("Full Name: \(fullName?.givenName ?? "") \(fullName?.familyName ?? "")")
            print("Email: \(email ?? "")")

            // يمكنك قم بتعيين الحالة لتعبر عن تسجيل الدخول الناجح
            isAuthenticated = true
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // حدث خطأ أثناء محاولة تسجيل الدخول
        print("Sign In with Apple failed. Error: \(error.localizedDescription)")

        // يمكنك قم بتعيين الحالة لتعبر عن تسجيل الدخول الفاشل
        isAuthenticated = false
    }
}

extension AuthenticationManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
}
