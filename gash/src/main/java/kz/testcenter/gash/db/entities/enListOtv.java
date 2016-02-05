package kz.testcenter.gash.db.entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "listotv", schema = "public")
public class enListOtv {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    private int id;

    @Column(name = "id_file")
    public int getIdFile() {
        return idFile;
    }
    public void setIdFile(int idFile) {
        this.idFile = idFile;
    }
    private int idFile;

    @Column(name = "class_no")
    public short getClassNo() {
        return classNo;
    }
    public void setClassNo(short classNo) {
        this.classNo = classNo;
    }
    private short classNo;

    @Column(name = "id_listotv")
    public int getIdListOtv() {
        return idListOtv;
    }
    public void setIdListOtv(int id_listotv) {
        this.idListOtv = id_listotv;
    }
    private int idListOtv;

    @Column(name = "id_test")
    public int getIdTest() {
        return idTest;
    }
    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }
    private int idTest;

    @Column(name = "liter_class")
    public String getLiterClass() {
        return literClass;
    }
    public void setLiterClass(String literClass) {
        this.literClass = literClass;
    }
    private String literClass;

    @Column(name = "s_fam")
    public String getsFam() {
        return sFam;
    }
    public void setsFam(String sFam) {
        this.sFam = sFam;
    }
    private String sFam;

    @Column(name = "fam")
    public String getFam() {
        return fam;
    }
    public void setFam(String fam) {
        this.fam = fam;
    }
    private String fam;

    @Column(name = "s_init")
    public String getsInit() {
        return sInit;
    }
    public void setsInit(String sInit) {
        this.sInit = sInit;
    }
    private String sInit;

    @Column(name = "init")
    public String getInit() {
        return init;
    }
    public void setInit(String init) {
        this.init = init;
    }
    private String init;

    @Column(name = "kpo_id_season")
    public short getKpoIdSeason() {
        return kpoIdSeason;
    }
    public void setKpoIdSeason(short kpoIdSeason) {
        this.kpoIdSeason = kpoIdSeason;
    }
    private short kpoIdSeason;

    @Column(name = "s_variant")
    public String getsVariant() {
        return sVariant;
    }
    public void setsVariant(String sVariant) {
        this.sVariant = sVariant;
    }
    private String sVariant;

    @Column(name = "variant")
    public short getVariant() {
        return variant;
    }
    public void setVariant(short variant) {
        this.variant = variant;
    }
    private short variant;

    @Column(name = "id_predmet1")
    public short getIdPredmet1() {
        return idPredmet1;
    }
    public void setIdPredmet1(short idPredmet1) {
        this.idPredmet1 = idPredmet1;
    }
    private short idPredmet1;

    @Column(name = "id_predmet2")
    public short getIdPredmet2() {
        return idPredmet2;
    }
    public void setIdPredmet2(short idPredmet2) {
        this.idPredmet2 = idPredmet2;
    }
    private short idPredmet2;

    @Column(name = "id_predmet3")
    public short getIdPredmet3() {
        return idPredmet3;
    }
    public void setIdPredmet3(short idPredmet3) {
        this.idPredmet3 = idPredmet3;
    }
    private short idPredmet3;

    @Column(name = "id_predmet4")
    public short getIdPredmet4() {
        return idPredmet4;
    }
    public void setIdPredmet4(short idPredmet4) {
        this.idPredmet4 = idPredmet4;
    }
    private short idPredmet4;

    @Column(name = "ord1")
    public short getOrd1() {
        return ord1;
    }
    public void setOrd1(short ord1) {
        this.ord1 = ord1;
    }
    private short ord1;

    @Column(name = "ord2")
    public short getOrd2() {
        return ord2;
    }
    public void setOrd2(short ord2) {
        this.ord2 = ord2;
    }
    private short ord2;

    @Column(name = "ord3")
    public short getOrd3() {
        return ord3;
    }
    public void setOrd3(short ord3) {
        this.ord3 = ord3;
    }
    private short ord3;

    @Column(name = "ord4")
    public short getOrd4() {
        return ord4;
    }
    public void setOrd4(short ord4) {
        this.ord4 = ord4;
    }
    private short ord4;

    @Column(name = "s_answers1")
    public String getsAnswers1() {
        return sAnswers1;
    }
    public void setsAnswers1(String sAnswers1) {
        this.sAnswers1 = sAnswers1;
    }
    private String sAnswers1;

    @Column(name = "s_answers2")
    public String getsAnswers2() {
        return sAnswers2;
    }
    public void setsAnswers2(String sAnswers2) {
        this.sAnswers2 = sAnswers2;
    }
    private String sAnswers2;

    @Column(name = "s_answers3")
    public String getsAnswers3() {
        return sAnswers3;
    }
    public void setsAnswers3(String sAnswers3) {
        this.sAnswers3 = sAnswers3;
    }
    private String sAnswers3;

    @Column(name = "s_answers4")
    public String getsAnswers4() {
        return sAnswers4;
    }
    public void setsAnswers4(String sAnswers4) {
        this.sAnswers4 = sAnswers4;
    }
    private String sAnswers4;

    @Column(name = "i_answers1")
    public String getiAnswers1() {
        return iAnswers1;
    }
    public void setiAnswers1(String iAnswers1) {
        this.iAnswers1 = iAnswers1;
    }
    private String iAnswers1;

    @Column(name = "i_answers2")
    public String getiAnswers2() {
        return iAnswers2;
    }
    public void setiAnswers2(String iAnswers2) {
        this.iAnswers2 = iAnswers2;
    }
    private String iAnswers2;

    @Column(name = "i_answers3")
    public String getiAnswers3() {
        return iAnswers3;
    }
    public void setiAnswers3(String iAnswers3) {
        this.iAnswers3 = iAnswers3;
    }
    private String iAnswers3;

    @Column(name = "i_answers4")
    public String getiAnswers4() {
        return iAnswers4;
    }
    public void setiAnswers4(String iAnswers4) {
        this.iAnswers4 = iAnswers4;
    }
    private String iAnswers4;

    @Column(name = "is_edit")
    public short getIsEdit() {
        return isEdit;
    }
    public void setIsEdit(short isEdit) {
        this.isEdit = isEdit;
    }
    private short isEdit;

    @Column(name = "edit_result")
    public short getEditResult() {
        return editResult;
    }
    public void setEditResult(short editResult) {
        this.editResult = editResult;
    }
    private short editResult;

    @Column(name = "is_iden")
    public short getIsIden() {
        return isIden;
    }
    public void setIsIden(short isIden) {
        this.isIden = isIden;
    }
    private short isIden;

    @Column(name = "itog_ocen")
    public short getItogOcen() {
        return itogOcen;
    }
    public void setItogOcen(short itogOcen) {
        this.itogOcen = itogOcen;
    }
    private short itogOcen;

    @Column(name = "ball1")
    public short getBall1() {
        return ball1;
    }
    public void setBall1(short ball1) {
        this.ball1 = ball1;
    }
    private short ball1;

    @Column(name = "ball2")
    public short getBall2() {
        return ball2;
    }
    public void setBall2(short ball2) {
        this.ball2 = ball2;
    }
    private short ball2;

    @Column(name = "ball3")
    public short getBall3() {
        return ball3;
    }
    public void setBall3(short ball3) {
        this.ball3 = ball3;
    }
    private short ball3;

    @Column(name = "ball4")
    public short getBall4() {
        return ball4;
    }
    public void setBall4(short ball4) {
        this.ball4 = ball4;
    }
    private short ball4;

    @Column(name = "ocen1")
    public short getOcen1() {
        return ocen1;
    }
    public void setOcen1(short ocen1) {
        this.ocen1 = ocen1;
    }
    private short ocen1;

    @Column(name = "ocen2")
    public short getOcen2() {
        return ocen2;
    }
    public void setOcen2(short ocen2) {
        this.ocen2 = ocen2;
    }
    private short ocen2;

    @Column(name = "ocen3")
    public short getOcen3() {
        return ocen3;
    }
    public void setOcen3(short ocen3) {
        this.ocen3 = ocen3;
    }
    private short ocen3;

    @Column(name = "ocen4")
    public short getOcen4() {
        return ocen4;
    }
    public void setOcen4(short ocen4) {
        this.ocen4 = ocen4;
    }
    private short ocen4;

    @Column(name = "is_ocen")
    public short getIsOcen() {
        return isOcen;
    }
    public void setIsOcen(short isOcen) {
        this.isOcen = isOcen;
    }
    private short isOcen;

    @Column(name = "date_time_scan")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getDateTimeScan() {
        return dateTimeScan;
    }
    public void setDateTimeScan(Date dateTimeScan) {
        this.dateTimeScan = dateTimeScan;
    }
    private Date dateTimeScan;

    @Column(name = "blank")
    public String getBlank() {
        return blank;
    }
    public void setBlank(String blank) {
        this.blank = blank;
    }
    private String blank;

    @Column(name = "lang")
    public short getLang() {
        return lang;
    }
    public void setLang(short lang) {
        this.lang = lang;
    }
    private short lang;

    @Column(name = "lo_file_name")
    public String getLoFileName() {
        return loFileName;
    }
    public void setLoFileName(String loFileName) {
        this.loFileName = loFileName;
    }
    private String loFileName;

    @Transient
    public short getOrd(short index) {
        switch (index) {
            case 1: return getOrd1();
            case 2: return getOrd2();
            case 3: return getOrd3();
            case 4: return getOrd4();
            default: return 0;
        }
    }

    @Transient
    public void setOrd(int index, short ord) {
        switch (index) {
            case 1: setOrd1(ord); break;
            case 2: setOrd2(ord); break;
            case 3: setOrd3(ord); break;
            case 4: setOrd4(ord); break;
        }
    }

    @Transient
    public short getIdPredmet(int index) {
        switch (index) {
            case 1: return getIdPredmet1();
            case 2: return getIdPredmet2();
            case 3: return getIdPredmet3();
            case 4: return getIdPredmet4();
            default: return 0;
        }
    }

    @Transient
    public void setIdPredmet(int index, short idPredmet) {
        switch (index) {
            case 1: setIdPredmet1(idPredmet); break;
            case 2: setIdPredmet2(idPredmet); break;
            case 3: setIdPredmet3(idPredmet); break;
            case 4: setIdPredmet4(idPredmet); break;
        }
    }

    @Transient
    public short getBall(int index) {
        switch (index) {
            case 1: return getBall1();
            case 2: return getBall2();
            case 3: return getBall3();
            case 4: return getBall4();
            default: return 0;
        }
    }

    @Transient
    public void setBall(int index, short ball) {
        switch (index) {
            case 1: setBall1(ball); break;
            case 2: setBall2(ball); break;
            case 3: setBall3(ball); break;
            case 4: setBall4(ball); break;
        }
    }

    @Transient
    public short getOcen(int index) {
        switch (index) {
            case 1: return getOcen1();
            case 2: return getOcen2();
            case 3: return getOcen3();
            case 4: return getOcen4();
            default: return 0;
        }
    }

    @Transient
    public void setOcen(int index, short ocen) {
        switch (index) {
            case 1: setOcen1(ocen); break;
            case 2: setOcen2(ocen); break;
            case 3: setOcen3(ocen); break;
            case 4: setOcen4(ocen); break;
        }
    }

    @Transient
    public String getsAnswers(int index) {
        switch (index) {
            case 1: return getsAnswers1();
            case 2: return getsAnswers2();
            case 3: return getsAnswers3();
            case 4: return getsAnswers4();
            default: return "";
        }
    }

    @Transient
    public void setsAnswers(int index, String sAnswers) {
        switch (index) {
            case 1: setsAnswers1(sAnswers); break;
            case 2: setsAnswers2(sAnswers); break;
            case 3: setsAnswers3(sAnswers); break;
            case 4: setsAnswers4(sAnswers); break;
        }
    }

    @Transient
    public String getiAnswers(int index) {
        switch (index) {
            case 1: return getiAnswers1();
            case 2: return getiAnswers2();
            case 3: return getiAnswers3();
            case 4: return getiAnswers4();
            default: return "";
        }
    }

    @Transient
    public void setiAnswers(int index, String iAnswers) {
        switch (index) {
            case 1: setiAnswers1(iAnswers); break;
            case 2: setiAnswers2(iAnswers); break;
            case 3: setiAnswers3(iAnswers); break;
            case 4: setiAnswers4(iAnswers); break;
        }
    }

    public enListOtv(){
        
    }
}
