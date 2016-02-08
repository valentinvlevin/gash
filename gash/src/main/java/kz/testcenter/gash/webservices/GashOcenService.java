package kz.testcenter.gash.webservices;

import kz.testcenter.gash.webservices.datatype.OcenRequest;
import kz.testcenter.gash.webservices.datatype.OcenResponse;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

@WebService(
        wsdlLocation = "META-INF/wsdl/GashOcen.wsdl"
)
public interface GashOcenService {
    @WebMethod(operationName = "isAlive")
    public Boolean isAlive();

    @WebMethod
    public OcenResponse DoAnalyze(@WebParam(name = "AnswerFile") OcenRequest ocenRequest);
}
