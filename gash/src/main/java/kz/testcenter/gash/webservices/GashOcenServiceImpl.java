package kz.testcenter.gash.webservices;

import kz.testcenter.gash.db.dao.ListOtvDAO;
import kz.testcenter.gash.exceptions.DAOException;
import kz.testcenter.gash.webservices.datatype.OcenRequest;
import kz.testcenter.gash.webservices.datatype.OcenResponse;
import kz.testcenter.gash.webservices.datatype.dtOcen;

import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import java.util.List;

import org.apache.cxf.annotations.EndpointProperties;
import org.apache.cxf.annotations.EndpointProperty;
import org.jboss.ws.api.annotation.EndpointConfig;

@WebService(
        endpointInterface = "kz.testcenter.gash.webservices.GashOcenService",
        serviceName = "GashOcenService",
        portName = "GashOcenPort"
)
@EndpointProperties(value = {
        @EndpointProperty(key = "ws-security.callback-handler", value = "kz.testcenter.gash.webservices.ServerPasswordCallback")
}
)public class GashOcenServiceImpl {
    @Inject
    private ListOtvDAO listOtvDAO;

    @WebMethod(operationName = "isAlive")
    public Boolean isAlive(){
        return true;
    }

    @WebMethod
    public OcenResponse DoAnalyze(@WebParam(name = "AnswerFile") OcenRequest ocenRequest) {
        OcenResponse ocenResponse = new OcenResponse();
        try {
            List<dtOcen> ocenList = listOtvDAO.DoOcen(ocenRequest);
            ocenResponse.setResultCode(0);
            ocenResponse.setOcenList(ocenList);
        } catch (DAOException e) {
            ocenResponse.setResultCode(e.getExceptionMessage().getCode());
            ocenResponse.setErrorMessage(e.getExceptionMessage().getErrorMessage());
        } catch (Exception e) {
            e.printStackTrace();
            ocenResponse.setResultCode(1);
            ocenResponse.setErrorMessage(e.getMessage());
        }
        return ocenResponse;
    }
}
