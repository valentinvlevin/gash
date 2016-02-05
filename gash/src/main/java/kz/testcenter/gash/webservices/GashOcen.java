package kz.testcenter.gash.webservices;

import kz.testcenter.gash.db.dao.ListOtvDAO;
import kz.testcenter.gash.exceptions.DAOException;
import kz.testcenter.gash.exceptions.DAONotFoundException;
import kz.testcenter.gash.webservices.datatype.OcenRequest;
import kz.testcenter.gash.webservices.datatype.OcenResponse;
import kz.testcenter.gash.webservices.datatype.dtOcen;

import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import java.util.List;

/**
 * Created by user on 14.09.2015.
 */
@WebService(
        serviceName = "GashOcenService",
        portName = "GashOcenPort",
        wsdlLocation = "https://res.testcenter.kz:28443/gash_ocen/GashOcen?wsdl"
)
@EndpointProperties()
public class GashOcen {
    @Inject
    private ListOtvDAO listOtvDAO;

    @WebMethod(operationName = "isAlive")
    public boolean isAlive(){
        return true;
    }

    @WebMethod
    public OcenResponse DoAnalyze(@WebParam(name = "AnswerFile") OcenRequest ocenRequest) {
        OcenResponse ocenResponse = new OcenResponse();
        try {
            List<dtOcen> ocenList = listOtvDAO.DoOcen(ocenRequest);
            ocenResponse.setResultCode(0);
            ocenResponse.setOcenList(ocenList);
        } catch (DAONotFoundException e) {
            ocenResponse.setResultCode(e.getExceptionMessage().getCode());
            ocenResponse.setErrorMessage(e.getExceptionMessage().getErrorMessage());
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
