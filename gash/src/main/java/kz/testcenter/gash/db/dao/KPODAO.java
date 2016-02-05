package kz.testcenter.gash.db.dao;

import kz.testcenter.gash.db.entities.kpo.enKPO;
import kz.testcenter.gash.db.entities.kpo.enKPOId;
import kz.testcenter.gash.exceptions.DAOException;
import kz.testcenter.gash.exceptions.DAONotFoundException;

import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.*;

/**
 * Created by user on 18.09.2015.
 */
@Stateless
@Startup
public class KPODAO {
    private final int MSG_COMMON_ERROR_CODE = 2000;
    private final int MSG_KODS_NOT_FOUND = MSG_COMMON_ERROR_CODE+1;

    private final String QRY_GET_KODS = "KPODAO.getKods";

    @Inject
    private EntityManager em;

    @PostConstruct
    public void init(){
        EntityManagerFactory emf = em.getEntityManagerFactory();
        Query q;

        q = em.createQuery(
                "select o.kods "
                +"from enKPO o "
                +"where o.idSeason=:idSeason and o.classNo=:classNo and o.variant=:variant and o.ord=:ord", String.class);
        emf.addNamedQuery(QRY_GET_KODS, q);
    }

    public String getKods(short idSeason, short classNo, short variant, short ord) throws DAOException {
        String kods;
        try {
            kods = em.createNamedQuery(QRY_GET_KODS, String.class)
                    .setParameter("idSeason", idSeason)
                    .setParameter("classNo", classNo)
                    .setParameter("variant", variant)
                    .setParameter("ord", ord)
                    .getSingleResult();
        } catch (NoResultException e) {
            throw new DAONotFoundException("Not found keys with params: "
                    +"idSeasion: "+idSeason+", "
                    +"classNo: "+classNo+", "
                    +"variant: "+variant+", "
                    +"ord: "+ord, MSG_KODS_NOT_FOUND);
        } catch (Exception e) {
            e.printStackTrace();
            throw new DAOException(e.getMessage(), MSG_COMMON_ERROR_CODE);
        }
        return kods;
    }
}
