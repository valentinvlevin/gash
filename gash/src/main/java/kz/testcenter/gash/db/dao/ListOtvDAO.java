package kz.testcenter.gash.db.dao;

import kz.testcenter.gash.AppContants;
import kz.testcenter.gash.db.entities.enAnswerFile;
import kz.testcenter.gash.db.entities.enListOtv;
import kz.testcenter.gash.db.entities.test.enTest;
import kz.testcenter.gash.db.entities.uchzav.enUchZav;
import kz.testcenter.gash.exceptions.DAOException;
import kz.testcenter.gash.exceptions.DAONotFoundException;
import kz.testcenter.gash.webservices.datatype.*;

import javax.ejb.Startup;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by user on 18.09.2015.
 */
@Stateless
@Startup
public class ListOtvDAO {
    private final int MSG_COMMON_ERROR_CODE = 1000;

    @Inject
    private EntityManager em;

    @Inject
    private KPODAO kpoDAO;

    public List<dtOcen> DoOcen(OcenRequest answerFile) throws DAOException {
        List<dtOcen> ocenList = null;
        try {
            enAnswerFile enAnsFile = new enAnswerFile();
            enAnsFile.setIdSeason(AppContants.ID_SEASON);
            enAnsFile.setIdVpt(answerFile.getIdVpt());
            enAnsFile.setArmSign(answerFile.getArmSign());
            enAnsFile.setNum(answerFile.getFileNum());
            enAnsFile.setCreateDateTime(answerFile.getCreateDateTime());
            enAnsFile.setImportDateTime(new Date());
            enAnsFile.setAnswerFileName("");
            enAnsFile.setResultFileName("");
            enAnsFile.setDataHash("");
            enAnsFile.setRandId(0);

            em.persist(enAnsFile);

            if (answerFile.getTestList() != null && answerFile.getTestList().size()>0) {
                int testCount = answerFile.getTestList().size();
                for (int i = 0; i < testCount; i++) {
                    enTest enTst = new enTest();
                    dtTest dtTst = answerFile.getTestList().get(i);

                    enTst.setIdFile(enAnsFile.getId());
                    enTst.setIdTest(dtTst.getIdTest());
                    enTst.setGidUchZav(dtTst.getGidUchZav());
                    enTst.setScanDate(dtTst.getScanDate());
                    enTst.setIdTestType(dtTst.getIdTestType());

                    em.persist(enTst);
                }
            }

            if (answerFile.getSchoolList() != null && answerFile.getSchoolList().size()>0) {
                int schoolCount = answerFile.getSchoolList().size();
                for (int i = 0; i < schoolCount; i++) {
                    enUchZav enUZ = new enUchZav();
                    dtSchool dtSch = answerFile.getSchoolList().get(i);

                    enUZ.setIdFile(enAnsFile.getId());
                    enUZ.setGidUchZav(dtSch.getId());
                    enUZ.setUchZavKaz(dtSch.getSchoolKaz());
                    enUZ.setUchZavRus(dtSch.getSchoolRus());

                    em.persist(enUZ);
                }
            }

            if (answerFile.getListOtvList() != null && answerFile.getListOtvList().size()>0) {
                int loCount = answerFile.getListOtvList().size();
                int ocenCount = 0;
                for (int i=0; i<loCount; i++)
                    if (answerFile.getListOtvList().get(i).getIsIden() == 1)
                        ocenCount++;

                ocenList = new ArrayList<dtOcen>(ocenCount);
                int ocenIndex = -1;
                for (int i=0; i<loCount; i++) {
                    dtListOtv dtLO = answerFile.getListOtvList().get(i);
                    enListOtv enLO = new enListOtv();

                    enLO.setIdFile(enAnsFile.getId());
                    enLO.setClassNo(dtLO.getClassNo());
                    enLO.setIdListOtv(dtLO.getIdListOtv());
                    enLO.setIdTest(dtLO.getIdTest());
                    enLO.setLiterClass(dtLO.getLiterClass());
                    enLO.setsFam(dtLO.getsFam());
                    enLO.setFam(dtLO.getFam());
                    enLO.setsInit(dtLO.getsInit());
                    enLO.setInit(dtLO.getInit());
                    enLO.setKpoIdSeason(dtLO.getKpoIdSeason());
                    enLO.setsVariant(dtLO.getsVariant());
                    enLO.setVariant(dtLO.getVariant());
                    enLO.setIsEdit(dtLO.getIsEdit());
                    enLO.setEditResult(dtLO.getEditResult());
                    enLO.setIsIden(dtLO.getIsIden());
                    enLO.setIsOcen(dtLO.getIsIden());
                    enLO.setDateTimeScan(dtLO.getDateTimeScan());
                    enLO.setBlank(dtLO.getBlank());
                    enLO.setLang(dtLO.getLang());
                    enLO.setLoFileName(dtLO.getLoFileName());

                    dtOcen ocen = null;
                    if (dtLO.getIsIden() == 1) {
                        ocenIndex++;
                        ocen = new dtOcen();
                        ocenList.add(ocenIndex, ocen);

                        ocen.setClassNo((byte)dtLO.getClassNo());
                        ocen.setIdListOtv(dtLO.getIdListOtv());
                    }

                    short sumBall = 0;
                    for (int predmetIndex = 0; predmetIndex < AppContants.MAX_PREDMET_COUNT; predmetIndex++) {
                        enLO.setIdPredmet(predmetIndex + 1, dtLO.getIdPredmet()[predmetIndex]);
                        enLO.setOrd(predmetIndex + 1, dtLO.getOrd()[predmetIndex]);
                        enLO.setsAnswers(predmetIndex + 1, dtLO.getAnswers()[predmetIndex]);

                        if (dtLO.getIsIden() == 1 && predmetIndex<AppContants.getPredmetCount(dtLO.getClassNo())) {
                            String kods = kpoDAO.getKods(dtLO.getKpoIdSeason(), dtLO.getClassNo(), dtLO.getVariant(), (short)(predmetIndex+1));
                            String answers = dtLO.getAnswers()[predmetIndex];

                            int questionCount = AppContants.getPredmetQuestionCount(dtLO.getClassNo());

                            StringBuffer iAnswers = new StringBuffer(questionCount);
                            short ball = 0;
                            for (int questionIndex=0; questionIndex < questionCount; questionIndex++)
                                if (kods.charAt(questionIndex) == answers.charAt(questionIndex)) {
                                    ball++;
                                    iAnswers.append('1');
                                } else
                                    iAnswers.append('0');

                            sumBall = (short) (sumBall + ball);

                            enLO.setiAnswers(predmetIndex + 1, iAnswers.toString());
                            enLO.setBall(predmetIndex + 1, ball);
                            ocen.getBalls()[predmetIndex] = (byte) ball;

                            enLO.setOcen(predmetIndex + 1, AppContants.getOcen(dtLO.getClassNo(), ball));
                            ocen.getOcen()[predmetIndex] = (byte) enLO.getOcen(predmetIndex + 1);
                        } else {
                            enLO.setiAnswers(predmetIndex + 1, "");
                            enLO.setBall(predmetIndex + 1, (short) 0);
                            enLO.setOcen(predmetIndex + 1, (short) 0);
                            enLO.setOrd(predmetIndex + 1, (short) 0);
                        }
                    }

                    if (dtLO.getIsIden() == 1) {
                        enLO.setItogOcen(AppContants.getItogOcen(dtLO.getClassNo(), sumBall));
                        ocen.setItogOcen((byte) enLO.getItogOcen());
                    } else
                        enLO.setItogOcen((short)0);

                    em.persist(enLO);
                }
            }

        } catch (DAONotFoundException e) {
            throw e;
        } catch (DAOException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new DAOException(e.getMessage(), MSG_COMMON_ERROR_CODE);
        }

        return ocenList;
    }
}
