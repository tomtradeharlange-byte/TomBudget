import Foundation
import LocalAuthentication
import CloudKit

class SecurityService {
    static let shared = SecurityService()
    
    func authenticateWithFaceID() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print("Face ID not available: \(error?.localizedDescription ?? "Unknown error")")
            return false
        }
        
        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Authenticate to access TomBudget"
            )
            return success
        } catch {
            print("Face ID authentication failed: \(error.localizedDescription)")
            return false
        }
    }
}

class CloudSyncService {
    static let shared = CloudSyncService()
    private let container = CKContainer.default()
    private let database: CKDatabase
    
    init() {
        self.database = container.privateCloudDatabase
    }
    
    func syncTransactions(_ transactions: [Transaction]) async throws {
        // TODO: Implement CloudKit sync
        print("Syncing \(transactions.count) transactions to iCloud...")
    }
    
    func fetchTransactions() async throws -> [Transaction] {
        // TODO: Implement CloudKit fetch
        return []
    }
}
