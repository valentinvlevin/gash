unit TBPCryptoConst;

// Copyright 2008-2009 Ritlabs SRL. All rights reserved.


interface

const
  (**
    Information about signer.
    Used as AType parameter in IVerifyResult.GetSignatureInfo
  *)
  vrcSignerCertData = 1;      //* Signer's certificate (BER encoded). Type: binary, size: variable.
  vrcSignerCertVfyResult = 2; //* Signer's certificate validity (see cvr* constants).Type: DWORD, size: 4 bytes.
  vrcSignerCode = 3;          //* Signature validity (see PSI_* constants). Type: DWORD, size: 4 байта.
  vrcSignerTime = 4;          //* Date and time when message was signed by this signer.

  (**
    Certificate properties.
    Used as APropertyType parameter in IVerifyResult.GetCertificateProperty
  *)
  cpSerialNumber        = 1;
  cpSignatureAlgorithmOID  = 2;
  cpIssuerLines         = 3;
  cpValidityNotBefore   = 4;
  cpValidityNotAfter    = 5;
  cpSubjectLines        = 6;
  cpSubjectPublicKeyAlgorithmOID = 7;
  cpSubjectEmails       = 9;
  cbBerCertificate      = 10;
  cpIssuerCaption       = 11;
  cpSubjectCaption      = 12;
  cpSignatureAlgorithmCaption = 15;
  cpSubjectPublicKeyAlgorithmCaption = 16;
  cpSubjectPublicKeyBits  = 17;

(**
  Signature verification status of the entire signed message
*)
const
(** The status of signature verification is undefined or incomplete *)
  SIGN_UNDEF               = 0;
(** Cannot arrange the signed content *)
  SIGN_PREPARE_CONTENT     = 1;
(** The data of the digital signature actually doesn't contain at leas one signer *)
  SIGN_NO_SIGNER_INFO      = 2;
(** At least one SignerInfo in the digital signature is invalid *)
  SIGN_INVALID_SI          = 3;
(** All of the emails of the senders of the message aren't found in the list of the emails of the ceritifcate subject *)
  SIGN_ADDR_MISMATCH       = 4;
(** Error in parsing BER signature PKCS7 object *)
  SIGN_OBJ_READ            = 5;
(** The digital signature is valid *)
  SIGN_OK                  = 6;
(** Error reading from the source string *)
  SIGN_STREAM_READ         = 7;
(** Error writing to the destination stream *)
  SIGN_STREAM_WRITE        = 8;
(** A Win32 API error has occured during the verification of the signature *)
  SIGN_WIN32               = 9;
(** An error while working with the token has occured during the verification of the signature *)
  SIGN_TOKEN_PKCS11        =10;
(** One of the digitals certificates used to verify this signature has expired *)
  SIGN_EXPIRED             =11;

  SIGN_TOKEN_CRYSTAL1      =12;
  SIGN_TOKEN_IKEY          =13;


type
  TCertVerifyResult = Cardinal;

(**
  Result of verification of a validity of a certificate
*)
const
  cvrUndef                        = 0;
  cvrOK                           = 1;
  cvrInternalErrorGetChain        = 2;
  cvrSignatureAlgorithmMismatch   = 3;
  cvrSignatureParamsMismatch      = 4;
  cvrNotYetValid                  = 5;
  cvrExpired                      = 6;
  cvrInappropriateAlgorithmMode   = 7;
  cvrInappropriateAlgorithmKey    = 8;
  cvrSignatureMatchFailed         = 9;
  cvrPathLengthExceeded           =10;
  cvrIssuerNotFound               =11;
  cvrRootNotTrusted               =12;
  cvrKeyMaterialMismatch          =13;
  cvrSignedByNonCA                =14;
  cvrSignedByNonSigning           =15;
  cvrIsUnknown                    =16;
  cvrInvalidKeyUsage              =17;
  cvrUnrecognizedCriticalExtension=18;


(**
  Status codes of TPreparedSignerInfo
*)
const
  PSI_UNDEF                = 0;
  PSI_CERT_NOT_FOUND       = 1;
  PSI_CERT_VFY_ERROR       = 2;
  PSI_NO_SIGNED_ATTRS      = 3;
  PSI_DIGEST_ALG_ERROR     = 4;
  PSI_CONTENT_DIGEST       = 5;
  PSI_SIGN_ALG_ERROR       = 6;
  PSI_SIGN_KEY_ERROR       = 7;
  PSI_SIGN_VFY_ERROR       = 8;
  PSI_IN_PROGRESS          = 9;
  PSI_OK                   = 10;


implementation

end.
