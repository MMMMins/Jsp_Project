var isEmpty = function(value){
    if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
        return true;
    }else{
        return false;
    }
};

function isCheck(){
    let name = frm.memName.value.replace(/ /g,"");
    let id = frm.memId.value.replace(/ /g,"");
    let pwd = frm.memPwd.value.replace(/ /g,"");
    let pwdCheck = frm.memPwdCheck.value.replace(/ /g,"");
    let email = frm.memEmail.value.replace(/ /g,"");
    let zipno = frm.memZipno.value.replace(/ /g,"");
    let idDup = frm.idDuplication.value;

    if(isEmpty(name) || !isCorrect(name)){
        frm.memName.value = null;
        document.getElementById("nameEffect").style.color="red";
        document.getElementById("nameEffect").style.visibility = "visible";
        document.frm.memName.focus();
        return false;
    }
    if(!frm.checkS.value){
        document.getElementById("checkSEffect").style.color="red";
        return false;
    }
    if(isEmpty(id) || !isId(id)){
        frm.memId.value = null;
        document.getElementById("idEffect").style.color="red";
        document.getElementById("idEffect").style.visibility = "visible";
        document.frm.memId.focus();
        return false;
    }
    if(idDup != "idCheck"){
        alert("아이디 중복확인을 해주세요.");
        return false;
    }
    if(isEmpty(pwd) || !isPassword(pwd)){
        frm.memPwd.value = null;
        document.getElementById("pwdEffect").style.color="red";
        document.getElementById("pwdEffect").style.visibility = "visible";
        document.frm.memPwd.focus();
        return false;
    }
    if(isEmpty(pwdCheck)){
        frm.memPwdCheck.value = null;
        document.frm.memPwdCheck.focus();
        return false;
    }
    if(pwdCheck != pwd){
        document.getElementById("pwdChkEffect").style.color="red";
        document.getElementById("pwdChkEffect").style.visibility = "visible";
        frm.memPwdCheck.value = null;
        document.frm.memPwdCheck.focus();
        return false;
    }
    if(isEmpty(email) || !isEmail(email)){
        document.getElementById("emailEffect").style.color="red";
        document.getElementById("emailEffect").style.visibility = "visible";
        document.frm.memEmail.focus();
        return false;
    }
    if(isEmpty(zipno)){
        alert("주소를 입력해주세요.");
        return false;
    }
}

function isId(asValue) {
    var regExp =  /^[A-za-z0-9]{5,20}$/g;
    return regExp.test(asValue);
}

function isEmail(asValue) {
    var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    return regExp.test(asValue);
}

function isCorrect(asValue) {
    var regExp = /^[a-zA-Zㄱ-힣][a-zA-Zㄱ-힣 ]*$/;
    return regExp.test(asValue);
}

function isPassword(asValue) {
    var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
    return regExp.test(asValue);
}