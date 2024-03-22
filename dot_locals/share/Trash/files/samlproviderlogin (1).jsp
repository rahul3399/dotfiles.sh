<%@ taglib prefix="s" uri="/struts-tags" %>
    <%@ taglib prefix="S" uri="/struts-tags" %>
        <%@ page import="com.miniorange.mobileauth.otp.loaders.data.persistent.CustomerPagesRebrandingPreferences" %>
            <%@ page import="com.miniorange.mobileauth.otp.loaders.utils.PropertiesRegistry" %>
                <!DOCTYPE html>

                <html>

                <head>
                    <meta charset="utf-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
                    <meta http-equiv="Pragma" content="no-cache" />
                    <meta http-equiv="Expires" content="0" />
                    <s:set var="brandingPreferences" value="getBrandingFromSession()" />
                    <s:set var="faviconPath" value="#brandingPreferences.faviconPath" />
                    <s:set var="customCSS" value="#brandingPreferences.customCssUrl" />
                    <link rel="shortcut icon" href="<s:property value=" faviconPath" />">
                    <title>User Login</title>
                    <!-- Bootstrap core CSS -->
                    <jsp:include page="/commonIncludes/commonCSS.jsp" />
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/css/login-style-ui.css?v=${project.version}">
                    <s:if test="%{#customCSS!=null && #customCSS.indexOf('.css')>0}">
                        <link rel="stylesheet" href="<s:property value=" #customCSS" />">
                    </s:if>
                    <script src="${pageContext.request.contextPath}/js/location.js?v=${project.version}"></script>

                </head>

                <body id="login-main-body" hidden>
                    <%--Adding values--%>
                        <s:set var="usernamePlaceholder" value="getText('saml.username.placeholder')" />
                        <s:set var="passwordPlaceholder" value="getText('saml.password.placeholder')" />
                        <s:set var="passwordPlaceholderminimum" value="getText('saml.password.minimumcharacters')" />
                        <s:set var="buttonText" value="getText('saml.login.button')" />
                        <s:set var="brandingId" value="#brandingPreferences.id" />
                        <s:set var="logoPath" value="#brandingPreferences.logoPath" />
                        <s:set var="allowRegistrations" value="#brandingPreferences.allowRegistrations" />
                        <s:set var="buttonColor" value="#brandingPreferences.buttonColor" />
                        <s:set var="loginPageText" value="#brandingPreferences.loginPageTitleText" />
                        <s:set var="language" value="#request['session']['WW_TRANS_I18N_LOCALE']" />
                        <s:set var="browserLanguage" value="#request['locale']" />
                        <s:set var="customJS" value="#brandingPreferences.customJavascriptUrl" />
                        <s:set var="customCSS" value="#brandingPreferences.customCssUrl" />
                        <s:set var="brandingId" value="#brandingPreferences.id" />
                        <s:set var="forgot" value="#brandingPreferences.forgotPwdPageUrl" />
                        <s:set var="signup" value="#brandingPreferences.userSignupPageUrl" />
                        <s:set var="backgroundColor" value="#brandingPreferences.backgroundColor" />

                        <div id="loading_image" class="collapse">
                            <s:property value="message" escapeHtml="false" />
                            <span id="message"></span>
                            <br>
                            <div class="loadingbar"></div>
                        </div>
                        <s:if test="%{#language==null || #language!=browserLanguage}">
                            <s:set var="language" value="#browserLanguage" />
                        </s:if>
                        <title>
                            <s:i18n name="login_page">
                                <s:text name="login.title" />
                            </s:i18n>
                        </title>
                        </title>
                        <div style="text-align: right;" id="i18n">
                            <s:set var="enablei18nDropdown" value="getEnableI18NDropdown()" />
                            <s:if test="%{#enablei18nDropdown==true}">
                                <div
                                    style="width: 12%;background: white;border-radius: 17px;margin-left: 87%;padding-left: 5px;padding-right: 5px">
                                    <i class="fa fa-globe fa-lg" aria-hidden="true"></i>
                                    <s:select onchange="languageInterceptor()" id="languageSelect"
                                        class="languageSelect minimal" list="%{dropdownLocales}" value="#language" />
                            </s:if>
                        </div>
                        </div>
                        <div id="login-body">
                            <br>
                            <div id="login-header">
                                <img src="<s:property value=" #brandingPreferences.logoPath" />" alt="logo"
                                class="img-responsive center-block"
                                style="height:auto; width:auto; max-height:70px;"/>
                            </div>
                            <br>
                            <div class="container-fluid">
                                <div id="login-wrapper" class="wrappersize-idp center-block" style='background-color:#<s:property value="backgroundColor"/>; border:1px solid #<s:property
                     value="backgroundColor"/>;'>
                                    <s:include value="idpmessages.jsp" /><br>
                                    <div class="login-header">

                                        <s:if test="%{#brandingId > 0}">
                                            <s:property escapeHtml="false" value="loginPageText" />
                                        </s:if>
                                        <s:else>
                                            <s:text name="saml.login.header" />
                                        </s:else>
                                    </div>
                                    <hr>
                                    <s:if
                                        test="username != null && username.trim() != '' && FirstFactorType == 'PASSWORD'">

                                        <form class="form login-form" id="idploginform"
                                            action="${pageContext.request.contextPath}/validatepassword" method="POST"
                                            autocomplete="off">
                                    </s:if>
                                    <s:else>
                                        <form class="form login-form" id="idploginform"
                                            action="${pageContext.request.contextPath}/idp/userlogin" method="POST"
                                            autocomplete="off">
                                    </s:else>
                                    <s:token />
                                    <s:hidden key="useragent" id="useragent" />
                                    <s:hidden key="collect" id="collect" />
                                    <div class="row">
                                        <div id="userName" class="col-xs-8 col-xs-offset-2">
                                            <s:textfield name="username" id="username"
                                                cssClass="form-control bottom-buffer" autofocus="true"
                                                placeholder="%{usernamePlaceholder}" required="true" />
                                        </div>
                                    </div>
                                    <div id="dynamicUserName" style="margin-bottom: 20px;"
                                        class="collapse login-header">
                                        <s:property value="username" />
                                    </div>

                                    <s:if test="%{FirstFactorType == 'PASSWORD' }">
                                        <div class="row">
                                            <div id="passwordspan" class="col-xs-8 col-xs-offset-2 bottom-buffer">
                                                <s:password name="password" id="plaintextPassword"
                                                    cssClass="form-control" placeholder="%{passwordPlaceholder}"
                                                    pattern=".{4,}" stitle="%{passwordPlaceholderminimum}" />
                                            </div>
                                        </div>
                                    </s:if>
                                    <s:include value="/commonIncludes/googlerecaptcha.jsp" />
                                    <input type="password" name="hiddenPassword" id="hiddenPassword" class="hidden"
                                        tabindex="-1" autofocus="false" />
                                    <div class="row">
                                        <div class="col-xs-8 col-xs-offset-2">
                                            <s:i18n name="global">
                                                <input type="submit" id="loginbutton" name="loginbutton" style="background-color:#<s:property
                                               value=" buttonColor" />; border-color:#
                                                <s:property value="buttonColor" />"
                                                class="btn btn-block mo-btn-primary" value="
                                                <s:text name="saml.login.button" />"/>
                                            </s:i18n>
                                        </div>
                                    </div>
                                    <br>
                                    </form>


                                    <s:iterator value="externalIdpConfigurationList" var="list">
                                        <div class="row">
                                            <div class="col-xs-8 col-xs-offset-2">
                                                <a
                                                    href='${pageContext.request.contextPath}/redirecttoidp?idpId=<s:property value="id"/>&customerId=<s:property value="customerId"/>'>
                                                    <button type="button" id="loginbutton" name="loginbutton" style="background-color:#<s:property
                                            value=" buttonColor" />; border-color:#
                                                    <s:property value="buttonColor" />"
                                                    class="btn btn-block mo-btn-primary" aria-label="Left Align">
                                                    <s:property value="idpDisplayName" /></button>
                                                </a>
                                            </div>
                                        </div>
                                        <br>
                                    </s:iterator>

                                    <s:if test="%{#allowRegistrations==true }">
                                        <s:if test="%{#signup!=null}">
                                            <div class="form-group"><a class="btn btn-link custom-small-text"
                                                    href="<s:property value=" signup" />">
                                                <s:text name="saml.login.create.account" /></a>
                                            </div>
                                        </s:if>
                                        <s:else>
                                            <div class="form-group"><a class="btn btn-link custom-small-text"
                                                    href="${pageContext.request.contextPath}/idp/usersignup">
                                                    <s:text name="saml.login.create.account" />
                                                </a></div>
                                        </s:else>
                                    </s:if>

                                    <s:if test="%{#brandingPreferences.showForgotPasswordLink==true }">
                                        <s:if test="%{#forgot!=null}">
                                            <div class="form-group"><a class="btn btn-link custom-small-text"
                                                    href="<s:property value=" forgot" />">
                                                <s:text name="saml.forgot.password" /></a>
                                            </div>
                                        </s:if>
                                        <s:else>
                                            <div class="form-group"><a class="btn btn-link custom-small-text"
                                                    href="${pageContext.request.contextPath}/idp/resetpassword">
                                                    <s:text name="saml.forgot.password" />
                                                </a></div>
                                        </s:else>
                                    </s:if>
                                    <!--<a class="btn mo-btn-primary btn-width btn-block button-center"
				style="background-color:#<s:property value="buttonColor"/>; border-color:#<s:property value="buttonColor"/>"
				href="${pageContext.request.contextPath}/login">Sign In to miniOrange Console</a>-->
                                    <form id="resetsession" action="resetsession">
                                        <s:hidden key="username" />
                                    </form>
                                </div>
                            </div>
                        </div>
                        <span id="flashObjectDiv" class="hidden" style="width:0;height:0;border:0; border:none;"></span>
                        <form style="display:hidden" id="offlineform" action="offlinemode" method="POST">
                            <s:token />
                            <input type="hidden" name="username" id="offlineusername" />
                        </form>
                        <form style="display:hidden" id="fpofflineform" action="offlineauthforpush" method="POST">
                            <s:token />
                            <input type="hidden" name="username" id="fpofflineusername" />
                        </form>
                        <form style="display:hidden" id="forgotphoneform" action="forgotphone" method="POST">
                            <s:token />
                            <input type="hidden" name="username" id="forgotphoneusername" />
                        </form>
                        <span hidden id="systemFonts"></span>

                        <div class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
                            id="ldapIdentifierModal" style="top: auto; bottom: auto">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header" style="border: 0;padding: 0 10px;">
                                        <button type="button" style="font-size: 50px; opacity: 0.9"
                                            class="close gotoBtn" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body" style="text-align: center;padding: 0 70px;">
                                        <i class="fa fa-lock" style="font-size: 60px" aria-hidden="true"></i>
                                        <h3>Tài khoản của bạn hiện đang bị khóa</h3>
                                        <p id="modalMessageContent" style="font-size:16px;color: #929292;">Tài khoản
                                            người dùng bị khóa do nhập sai OTP nhiều lần.
                                            Tài khoản sẽ được tự động mở khóa sau <span id="countdown">30</span> phút.
                                            Sau đó, người dùng có thể đăng nhập lại HMS.
                                        </p>
                                    </div>
                                    <div class="modal-footer" style="border: 0;text-align: center;padding: 25px;">
                                        <button type="button" class="btn btn-secondary gotoBtn"
                                            style="background: #CC0001;color: #fff;padding: 8px 20px;">Quay lại trang
                                            đăng nhập</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <jsp:include page="/commonIncludes/commonJS.jsp" />
                        <script
                            src="${pageContext.request.contextPath}/js/accountChooser.js?v=${project.version}"></script>
                        <s:if test="%{isFraudPreventionEnabled}">
                            <s:set var="rbaHeaders" value="#request['session']['rbaAuthHeaders']" />
                            <script> var rbaAuthHeaders = '<s:property value="rbaHeaders"/>'; </script>
                            <script
                                src="${pageContext.request.contextPath}/js/collect_device_attributes.js?v=${project.version}"></script>
                        </s:if>
                        <script>var contextpath = "${pageContext.request.contextPath}";</script>
                        <script src="${pageContext.request.contextPath}/js/userlogin-fp.js?v=${project.version}"
                            contextpath="${pageContext.request.contextPath}"></script>
                        <script>
                            $(document).ready(function () {
                                $('.hidden').hide().removeClass('hidden');
                                <s:if test="%{FirstFactorType == 'PASSWORD' }">
                                    passwordShow();
                                </s:if>
                            });
                            $("#signinLink").click(function (e) {
                                e.preventDefault();
                                $("#resetsession").submit();
                            });
                            $("#idploginform").submit(function (e) {
                                e.preventDefault();
                                $('#loading_image').show();
                                var currentTarget = e.target;
                                var username = document.getElementById("username").value;
                                var offline = document.getElementById("offlineusername");
                                var fpofflineusername = document.getElementById("fpofflineusername");
                                var forgotphone = document.getElementById("forgotphoneusername");
                                offline.value = username;
                                fpofflineusername.value = username;
                                forgotphone.value = username;
                                var useragentValue = $('#useragent').val();
                                if (fraud_prevention_enabled == true && $("#collect").val() != "false") {
                                    console.log("Fraud prevention enabled");
                                    var intervalFPAttributes = setInterval(function () {
                                        if ($("#jsonRBAAttributes").val() === null || $("#jsonRBAAttributes").val() === "") {
                                            console.log("Have not received RBA Attributes so far");
                                        } else {
                                            console.log("Received RBA Attributes");
                                            var jsonAttr = $("#jsonRBAAttributes").val();
                                            console.log("RBA Attributes: " + jsonAttr);
                                            stopIntervalTimer(intervalFPAttributes);
                                            jQuery.ajax({
                                                url: "${pageContext.request.contextPath}/rest/device/" + username,
                                                type: "POST",
                                                data: $('#jsonRBAAttributes').val(),
                                                dataType: "text",
                                                contentType: "application/json; charset=utf-8",
                                                success: function (results) {
                                                    //alert("here1");
                                                    currentTarget.submit();
                                                }, error: function (xhr, error) {
                                                    currentTarget.submit();
                                                }

                                            });
                                        }
                                    }, 100);
                                } else {
                                    currentTarget.submit();
                                }
                            });

                            function checkFraudPrevention() {
                                <s:if test="%{isFraudPreventionEnabled}">
                                    fraud_prevention_enabled = true;
                                    collectRbaAttributes();
                                </s:if>
                            }
                            $('.gotoBtn').on('click', function () {
                                window.location.href = "http://localhost:8080/" + $(this).text().toLowerCase();
                            });








                            function countdown() {
                                var countdownElement = document.getElementById('countdown');
                                var countdownValue = parseInt(countdownElement.innerText);

                                if (--countdownValue > 0) {
                                    countdownElement.innerText = countdownValue;
                                } else {
                                    window.location.href = 'http://localhost:8080/idp/validatenextfactor';
                                }
                                setTimeout(countdown, 1000 * 60);
                            }
                            window.onload = countdown;















                            function updateCountdown() {
                                $("#modalMessageContent").html("Tài khoản người dùng bị khóa do nhập sai OTP nhiều lần. Tài khoản sẽ được tự động mở khóa sau " + countdownMinutes + " phút. Sau đó, người dùng có thể đăng nhập lại HMS.");
                            }

                            var countdownElement = $("#modalMessageContent");

                            var errorMessageSpan = $(".errorMessage li span");
                            if (errorMessageSpan.length) {
                                var countdownMinutes = parseInt(errorMessageSpan.text().match(/\d+/)[0]);
                                updateCountdown();

                                var countdownInterval = setInterval(function () {
                                    if (--countdownMinutes > 0) {
                                        updateCountdown();
                                    } else {
                                        clearInterval(countdownInterval);
                                        window.location.href = "http://localhost:8080/idp/validatenextfactor";

                                    }
                                }, 60000);
                            }

                        </script>

                        <input type="hidden" value="login" id="testType">
                        <input type="hidden" value="" id="jsonRBAAttributes">
                        <s:if test="%{isFraudPreventionEnabled}">
                            <iframe id='myframe' onload="startSession();" hidden
                                style="width:0;height:0;border:0; border:none;"></iframe>
                            <script
                                src="${pageContext.request.contextPath}/js/swfobject.js?v=${project.version}"></script>
                            <script
                                src="${pageContext.request.contextPath}/js/fontdetect.js?v=${project.version}"></script>
                            <script src="${pageContext.request.contextPath}/js/client.js?v=${project.version}"></script>
                            <script
                                src="${pageContext.request.contextPath}/js/ua-parser.js?v=${project.version}"></script>
                            <script
                                src="${pageContext.request.contextPath}/js/murmurhash3.js?v=${project.version}"></script>
                        </s:if>
                        <s:if test="%{#customJS!=null && #customJS.indexOf('.js')>0}">
                            <script src="<s:property value=" #customJS" />"></script>
                        </s:if>

                        <script>
                            $(document).ready(function () {
                                $("body").show();
                                var isElementPresent = false
                                var findHtml = $(".alert-danger").html();
                                var pattern = /account has been locked/;
                                if (pattern.test(findHtml)) {
                                    isElementPresent = true
                                } else {
                                    isElementPresent = false
                                }
                                if (isElementPresent) {
                                    $('#ldapIdentifierModal').modal('show');
                                    $("#login-wrapper").hide()
                                }
        <s:if test="username != null && username.trim() != '' && FirstFactorType == 'PASSWORD'">$("#plaintextPassword").focus()
        </s:if><s:else>$("#username").focus()</s:else>;
                            });

                            function languageInterceptor() {
                                var dropdown = document.getElementById("languageSelect");
                                var selectedIndex = dropdown.selectedIndex;
                                var valueofIndex = dropdown.options[selectedIndex].value;
                                let uri = new URL(window.location.href);
                                uri.searchParams.delete("request_locale");
                                uri.searchParams.append("request_locale", valueofIndex);
                                window.document.location.href = uri
                                $("languageSelect").val(selectedIndex);
                            }
                        </script>
                </body>

                </html>