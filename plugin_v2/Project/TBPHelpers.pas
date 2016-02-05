unit TBPHelpers;

interface

uses
  TBPInterface;

function TBPGetStr(const SP: ITBPStringProvider; const ID: Integer): string;
function TBPGetWStr(const SP: ITBPStringProvider; const ID: Integer): WideString;
function TBPGetStrEx(const SP: ITBPStringProvider;
  const ID: Integer; out Res: string): Boolean;
function TBPGetWStrEx(const SP: ITBPStringProvider;
  const ID: Integer; out Res: WideString): Boolean;
function TBPGetStrDef(const SP: ITBPStringProvider;
  const ID: Integer; const Def: string): string;
function TBPGetWStrDef(const SP: ITBPStringProvider;
  const ID: Integer; const Def: WideString): WideString;

function TBPGetVerInfo(const CB: ITBPCoreBridge; const ID: Integer): WideString;
function TBPGetRegInfo(const CB: ITBPCoreBridge; const ID: Integer): WideString;

implementation

uses
  Windows;

function TBPGetStr(const SP: ITBPStringProvider; const ID: Integer): string;
begin
  if not TBPGetStrEx(SP, ID, Result) then Result := '';
end;

function TBPGetWStr(const SP: ITBPStringProvider; const ID: Integer): WideString;
begin
  if not TBPGetWStrEx(SP, ID, Result) then Result := '';
end;

function TBPGetStrEx(const SP: ITBPStringProvider;
  const ID: Integer; out Res: string): Boolean;
var
  Buf: array [0..1023] of Char;
  L: Cardinal;
begin
  case SP.GetString(ID, @Buf[0], SizeOf(Buf), L) of
    S_OK: begin
      SetLength(Res, L);
      Move(Buf, Res[1], L);
      Result := True;
    end;
    TYPE_E_BUFFERTOOSMALL: begin
      SetLength(Res, L);
      Result := (SP.GetString(ID, PChar(Res), L, L) = S_OK);
    end;
    else Result := False;
  end;
end;

function TBPGetWStrEx(const SP: ITBPStringProvider;
  const ID: Integer; out Res: WideString): Boolean;
const
  BufSize = 1024;
var
  Buf: array [0..BufSize-1] of WideChar;
  L: Cardinal;
begin
  case SP.GetWidestring(ID, @Buf[0], BufSize, L) of
    S_OK: begin
      SetLength(Res, L);
      if L>0 then
        Move(Buf, Res[1], L * SizeOf(WideChar));
      Result := True;
    end;
    TYPE_E_BUFFERTOOSMALL: begin
      SetLength(Res, L);
      Result := (SP.GetWidestring(ID, PWideChar(Res), L, L) = S_OK);
    end;
    else Result := False;
  end;
end;

function TBPGetStrDef(const SP: ITBPStringProvider;
  const ID: Integer; const Def: string): string;
begin
  if not TBPGetStrEx(SP, ID, Result) then Result := Def;
end;

function TBPGetWStrDef(const SP: ITBPStringProvider;
  const ID: Integer; const Def: WideString): WideString;
begin
  if not TBPGetWStrEx(SP, ID, Result) then Result := Def;
end;

function TBPGetVerInfo(const CB: ITBPCoreBridge; const ID: Integer): WideString;
const
  BufSize = 1024;
var
  Buf: array [0..BufSize-1] of WideChar;
  L: Cardinal;
begin
  case CB.GetVersionInfo(ID, @Buf[0], BufSize, L) of
    S_OK: begin
      SetLength(Result, L);
      Move(Buf, Result[1], L * SizeOf(WideChar));
    end;
    TYPE_E_BUFFERTOOSMALL: begin
      SetLength(Result, L);
      if CB.GetVersionInfo(ID, PWideChar(Result), L, L) <> S_OK then Result := '';
    end;
    else Result := '';
  end;
end;

function TBPGetRegInfo(const CB: ITBPCoreBridge; const ID: Integer): WideString;
const
  BufSize = 1024;
var
  Buf: array [0..BufSize-1] of WideChar;
  L: Cardinal;
begin
  case CB.GetRegistrationInfo(ID, @Buf[0], BufSize, L) of
    S_OK: begin
      SetLength(Result, L);
      Move(Buf, Result[1], L * SizeOf(WideChar));
    end;
    TYPE_E_BUFFERTOOSMALL: begin
      SetLength(Result, L);
      if CB.GetRegistrationInfo(ID, PWideChar(Result), L, L) <> S_OK then Result := '';
    end;
    else Result := '';
  end;
end;

end.
