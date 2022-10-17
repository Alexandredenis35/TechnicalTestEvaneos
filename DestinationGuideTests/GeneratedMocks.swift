import Cuckoo
@testable import DestinationGuide
import Foundation

class MockGetRecentDestinationUseCase: GetRecentDestinationUseCase, Cuckoo.ClassMock {
    typealias MocksType = GetRecentDestinationUseCase

    typealias Stubbing = __StubbingProxy_GetRecentDestinationUseCase
    typealias Verification = __VerificationProxy_GetRecentDestinationUseCase

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    private var __defaultImplStub: GetRecentDestinationUseCase?

    func enableDefaultImplementation(_ stub: GetRecentDestinationUseCase) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    override func execute(
        newRecentDestinations: DestinationDetails,
        currentRecentDestinations: [DestinationDetails]
    ) -> [DestinationDetails] {
        return cuckoo_manager.call(
            """
            execute(newRecentDestinations: DestinationDetails, currentRecentDestinations: [DestinationDetails]) -> [DestinationDetails]
            """,
            parameters: (newRecentDestinations, currentRecentDestinations),
            escapingParameters: (newRecentDestinations, currentRecentDestinations),
            superclassCall:

            super.execute(
                newRecentDestinations: newRecentDestinations,
                currentRecentDestinations: currentRecentDestinations
            ),

            defaultCall: __defaultImplStub!.execute(
                newRecentDestinations: newRecentDestinations,
                currentRecentDestinations: currentRecentDestinations
            )
        )
    }

    struct __StubbingProxy_GetRecentDestinationUseCase: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            cuckoo_manager = manager
        }

        func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(
            newRecentDestinations: M1,
            currentRecentDestinations: M2
        ) -> Cuckoo
            .ClassStubFunction<(DestinationDetails, [DestinationDetails]), [DestinationDetails]>
            where M1.MatchedType == DestinationDetails, M2.MatchedType == [DestinationDetails] {
            let matchers: [Cuckoo.ParameterMatcher<(DestinationDetails, [DestinationDetails])>] = [
                wrap(matchable: newRecentDestinations) { $0.0 },
                wrap(matchable: currentRecentDestinations) { $0.1 }
            ]
            return .init(stub: cuckoo_manager.createStub(
                for: MockGetRecentDestinationUseCase.self,
                method:
                """
                execute(newRecentDestinations: DestinationDetails, currentRecentDestinations: [DestinationDetails]) -> [DestinationDetails]
                """,
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_GetRecentDestinationUseCase: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        @discardableResult func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(
            newRecentDestinations: M1,
            currentRecentDestinations: M2
        ) -> Cuckoo
            .__DoNotUse<(DestinationDetails, [DestinationDetails]), [DestinationDetails]>
            where M1.MatchedType == DestinationDetails, M2.MatchedType == [DestinationDetails] {
            let matchers: [Cuckoo.ParameterMatcher<(DestinationDetails, [DestinationDetails])>] = [
                wrap(matchable: newRecentDestinations) { $0.0 },
                wrap(matchable: currentRecentDestinations) { $0.1 }
            ]
            return cuckoo_manager.verify(
                """
                execute(newRecentDestinations: DestinationDetails, currentRecentDestinations: [DestinationDetails]) -> [DestinationDetails]
                """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation
            )
        }
    }
}

class GetRecentDestinationUseCaseStub: GetRecentDestinationUseCase {
    override func execute(
        newRecentDestinations _: DestinationDetails,
        currentRecentDestinations _: [DestinationDetails]
    ) -> [DestinationDetails] {
        return DefaultValueRegistry.defaultValue(for: [DestinationDetails].self)
    }
}
