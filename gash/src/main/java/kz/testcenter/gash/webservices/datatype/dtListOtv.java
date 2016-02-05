package kz.testcenter.gash.webservices.datatype;

import javax.xml.bind.annotation.*;
import java.util.Date;
import kz.testcenter.gash.AppContants;

@XmlAccessorType(XmlAccessType.PROPERTY)
@XmlType(name = "dtListOtv", propOrder = {
        "classNo",
        "idTest",
        "idListOtv",
        "literClass",
        "sFam",
        "fam",
        "sInit",
        "init",
        "kpoIdSeason",
        "sVariant",
        "variant",
        "idPredmet",
        "ord",
        "answers",
        "isIden",
        "isEdit",
        "editResult",
        "lang",
        "blank",
        "loFileName",
        "dateTimeScan"
})
public class dtListOtv {
    @XmlElement(name = "class_no")
    public short getClassNo() {
        return classNo;
    }
    public void setClassNo(short classNo) {
        this.classNo = classNo;
    }
    private short classNo;

    @XmlElement(name = "id_listotv", required = true)
    public int getIdListOtv() {
        return idListOtv;
    }
    public void setIdListOtv(int idListOtv) {
        this.idListOtv = idListOtv;
    }
    private int idListOtv;

    @XmlElement(name = "id_test", required = true)
    public int getIdTest() {
        return idTest;
    }
    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }
    private int idTest;

    @XmlElement(name = "liter_class", required = true)
    public String getLiterClass() {
        return literClass;
    }
    public void setLiterClass(String literClass) {
        this.literClass = literClass;
    }
    private String literClass;

    @XmlElement(name = "s_fam", required = true)
    public String getsFam() {
        return sFam;
    }
    public void setsFam(String sFam) {
        this.sFam = sFam;
    }
    private String sFam;

    @XmlElement(name = "fam", required = true)
    public String getFam() {
        return fam;
    }
    public void setFam(String fam) {
        this.fam = fam;
    }
    private String fam;

    @XmlElement(name = "s_init", required = true)
    public String getsInit() {
        return sInit;
    }
    public void setsInit(String sInit) {
        this.sInit = sInit;
    }
    private String sInit;

    @XmlElement(name = "init", required = true)
    public String getInit() {
        return init;
    }
    public void setInit(String init) {
        this.init = init;
    }
    private String init;

    @XmlElement(name = "kpo_id_season", required = true)
    public byte getKpoIdSeason() {
        return kpoIdSeason;
    }
    public void setKpoIdSeason(byte kpoIdSeason) {
        this.kpoIdSeason = kpoIdSeason;
    }
    private byte kpoIdSeason;

    @XmlElement(name = "s_variant", required = true)
    public String getsVariant() {
        return sVariant;
    }
    public void setsVariant(String sVariant) {
        this.sVariant = sVariant;
    }
    private String sVariant;

    @XmlElement(name = "variant", required = true)
    public short getVariant() {
        return variant;
    }
    public void setVariant(short variant) {
        this.variant = variant;
    }
    private short variant;

    @XmlElement(name = "id_predmets", required = true)
    public byte[] getIdPredmet() {
        return idPredmet;
    }
    public void setIdPredmet(byte[] idPredmet) {
        this.idPredmet = idPredmet;
    }
    private byte[] idPredmet = new byte[AppContants.MAX_PREDMET_COUNT];

    @XmlElement(name = "ords", required = true)
    public byte[] getOrd() {
        return ord;
    }
    public void setOrd(byte[] ord) {
        this.ord = ord;
    }
    private byte[] ord = new byte[AppContants.MAX_PREDMET_COUNT];

    @XmlElement(name = "answers", required = true)
    public String[] getAnswers() {
        return answers;
    }
    public void setAnswers(String[] answers) {
        this.answers = answers;
    }
    private String[] answers = new String[AppContants.MAX_PREDMET_COUNT];

    @XmlElement(name = "is_iden", required = true)
    public byte getIsIden() {
        return isIden;
    }
    public void setIsIden(byte isIden) {
        this.isIden = isIden;
    }
    private byte isIden;

    @XmlElement(name = "is_edit", required = true)
    public byte getIsEdit() {
        return isEdit;
    }
    public void setIsEdit(byte isEdit) {
        this.isEdit = isEdit;
    }
    private byte isEdit;

    @XmlElement(name = "edit_result", required = true)
    public byte getEditResult() {
        return editResult;
    }
    public void setEditResult(byte editResult) {
        this.editResult = editResult;
    }
    public byte editResult;

    @XmlElement(name = "lang", required = true)
    public byte getLang() {
        return lang;
    }
    public void setLang(byte lang) {
        this.lang = lang;
    }
    private byte lang;

    @XmlElement(name = "blank", required = true)
    public String getBlank() {
        return blank;
    }
    public void setBlank(String blank) {
        this.blank = blank;
    }
    private String blank;

    @XmlElement(name = "lo_filename", required = true)
    public String getLoFileName() {
        return loFileName;
    }
    public void setLoFileName(String loFileName) {
        this.loFileName = loFileName;
    }
    private String loFileName;

    @XmlElement(name = "date_time_scan", required = true)
    public Date getDateTimeScan() {
        return dateTimeScan;
    }
    public void setDateTimeScan(Date dateTimeScan) {
        this.dateTimeScan = dateTimeScan;
    }
    private Date dateTimeScan;
}
