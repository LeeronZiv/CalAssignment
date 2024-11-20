//
//  EncryptionService.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 20/11/2024.
//

import Foundation
import CryptoKit
import LocalAuthentication
import Security

class BiometricEncryptionService {
    
    private var encryptionKey: SymmetricKey?
    
    init() {
        self.encryptionKey = self.fetchEncryptionKey()
        if self.encryptionKey == nil {
            self.encryptionKey = SymmetricKey(size: .bits256)
            self.saveEncryptionKey(self.encryptionKey!)
        }
    }
    
    private func fetchEncryptionKey() -> SymmetricKey? {
        guard let keyData = KeychainService.retrieve(key: "encryptionKey") else { return nil }
        return SymmetricKey(data: keyData)
    }
    
    private func saveEncryptionKey(_ key: SymmetricKey) {
        KeychainService.save(key: "encryptionKey", data: key.withUnsafeBytes { Data($0) })
    }

    // Encrypt data after biometric authentication
    func encryptWithBiometricAuthentication<T: Encodable>(_ object: T, completion: @escaping (String?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print("Biometric authentication is not available.")
            completion(nil)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to encrypt your data.") { success, authenticationError in
            if success {
                self.performEncryption(object, completion: completion)
            } else {
                print("Authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
    
    private func performEncryption<T: Encodable>(_ object: T, completion: @escaping (String?) -> Void) {
        guard let key = encryptionKey else {
            completion(nil)
            return
        }
        
        guard let data = try? JSONEncoder().encode(object) else {
            print("Failed to encode object.")
            completion(nil)
            return
        }
        
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            let encryptedData = sealedBox.combined
            let encryptedString = encryptedData?.base64EncodedString()
            print("Encrypted data: \(encryptedString ?? "Encryption failed")")
            completion(encryptedString)
        } catch {
            print("Encryption failed: \(error)")
            completion(nil)
        }
    }
    
    // Decrypt data after biometric authentication
    func decryptWithBiometricAuthentication<T: Decodable>(_ encryptedString: String, completion: @escaping (T?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print("Biometric authentication is not available.")
            completion(nil)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to decrypt your data.") { success, authenticationError in
            if success {
                self.performDecryption(encryptedString, completion: completion)
            } else {
                print("Authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
    
    private func performDecryption<T: Decodable>(_ encryptedString: String, completion: @escaping (T?) -> Void) {
        guard let key = encryptionKey else {
            completion(nil)
            return
        }
        
        guard let data = Data(base64Encoded: encryptedString) else {
            print("Failed to decode encrypted data.")
            completion(nil)
            return
        }
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            
            let decodedObject = try JSONDecoder().decode(T.self, from: decryptedData)
            completion(decodedObject)
        } catch {
            print("Decryption failed: \(error)")
            completion(nil)
        }
    }
}
