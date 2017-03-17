Mock Story

Narrative:
In order to simulate service behaviour
As a test framework
I want to raise and check for exceptions
					 
Scenario:  Throw an exception and check for it
Given exception java.lang.RuntimeException thrown calling service org.wmaop.test.services:svcB always
When invoke org.wmaop.test.services:rootSvc without idata
Then exception java.lang.RuntimeException was thrown
And pipeline has varA == "A"

Scenario: Set a condition and check its not fired - test will pass as not interrupted by exception
Given exception java.lang.RuntimeException thrown calling service org.wmaop.test.services:svcB when lorem == "flopsum" 
When invoke org.wmaop.test.services:rootSvc with data/lorem.xml

Scenario: Throw conditional exception
Given exception java.lang.RuntimeException thrown calling service org.wmaop.test.services:svcB when lorem == "ipsum" 
When invoke org.wmaop.test.services:rootSvc with data/lorem.xml
Then exception java.lang.RuntimeException was thrown

Scenario: Throw conditional exception after service
Given exception java.lang.RuntimeException thrown after calling service org.wmaop.test.services:svcB when varA == "A"
When invoke org.wmaop.test.services:rootSvc with data/lorem.xml
Then exception java.lang.RuntimeException was thrown
And pipeline has varB == "B"

Scenario: Throw conditional exception before service
Given exception java.lang.RuntimeException thrown before calling service org.wmaop.test.services:svcB always
When invoke org.wmaop.test.services:rootSvc with data/lorem.xml
Then exception java.lang.RuntimeException was thrown
And pipeline has varB != "B"

Scenario: Check exception message.  Note exceptionMessage is set AFTER the 'exception .. was thrown' check is made.
When invoke org.wmaop.test.services:exceptionSvc without idata
Then exception com.wm.app.b2b.server.ServiceException was thrown
And pipeline has exceptionMessage.contains("Service interface name required")

Scenario: Create exception with message
Given exception java.lang.RuntimeException("MyException") thrown after calling service org.wmaop.test.services:svcB when varA == "A"
When invoke org.wmaop.test.services:rootSvc with data/lorem.xml
Then exception java.lang.RuntimeException was thrown
And pipeline has exceptionMessage.contains("MyException")
