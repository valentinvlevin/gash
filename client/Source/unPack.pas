unit unPack;

interface

uses
  Windows, Messages, SysUtils, Classes;

const
  RES_OK = 0;
  // Ошибки упаковки
  PF_NoDataToSend = 1;

  // Ошибки распаковки
  UPF_FileToSmall = 1;
  UPF_HashChanged = 2;

function CreatePackFileFromMemory(InData: Pointer; InDataSize: Integer;
  FileHeader: Pointer; FileHeaderSize: Integer;
  OutData: TStream): Integer;

function CreatePackFile(InData: TStream;
  FileHeader: Pointer; FileHeaderSize: Integer;
  OutData: TStream): Integer;

function UnpackFile(InData: TStream;
  FileHeader: Pointer; FileHeaderSize: Integer;
  OutData: TStream): Integer;

function CheckFile(InData: TStream; const FileHeaderSize: Integer): Boolean;

implementation

uses
  zLibEx, MD5;

function CreatePackFileFromMemory(InData: Pointer; InDataSize: Integer;
  FileHeader: Pointer; FileHeaderSize: Integer;
  OutData: TStream): Integer;
var
  ms: TMemoryStream;
begin
  ms:=TMemoryStream.Create;
  ms.WriteBuffer(InData^, InDataSize);
  ms.Seek(0, soFromBeginning);

  try
    Result := CreatePackFile(ms, FileHeader, FileHeaderSize, OutData);
  finally
    FreeAndNil(ms);
  end;
end;

function CreatePackFile(InData: TStream;
  FileHeader: Pointer; FileHeaderSize: Integer;
  OutData: TStream): Integer;
var
  Hash: Pointer;
  CompressedData: TMemoryStream;
begin
  Result := RES_OK;

  if InData.Size = 0 then
  begin
    Result := PF_NoDataToSend;
    Exit;
  end;

  InData.Seek(0, soFromBeginning);

  CompressedData := TMemoryStream.Create;

  try
    ZCompressStream(InData, CompressedData, zcMax);
  except
    FreeAndNil(CompressedData);
    raise;
  end;

  try
    OutData.WriteBuffer(FileHeader^, FileHeaderSize);

    GetMem(Hash, HashSize);
    try
      CompressedData.Seek(0, soFromBeginning);
      GetHash(CompressedData.Memory, CompressedData.Size, Hash);
      OutData.WriteBuffer(Hash^, HashSize);
    finally
      FreeMem(Hash);
    end;

    CompressedData.Seek(0, soFromBeginning);
    OutData.CopyFrom(CompressedData, CompressedData.Size);
  finally
    FreeAndNil(CompressedData);
  end;
end;

function UnpackFile(InData: TStream;
  FileHeader: Pointer; FileHeaderSize: Integer;
  OutData: TStream): Integer;
var
  Hash, HashFromFile: Pointer;
  CompressedData: TMemoryStream;
begin
  Result := RES_OK;

  CompressedData := nil;

  try
    if InData.Size<FileHeaderSize + HashSize then
    begin
      Result := UPF_FileToSmall;
      Exit;
    end;

    InData.Seek(0, soFromBeginning);

    InData.ReadBuffer(FileHeader^, FileHeaderSize);

    CompressedData := TMemoryStream.Create;

    GetMem(Hash, HashSize);
    GetMem(HashFromFile, HashSize);

    try
      InData.ReadBuffer(HashFromFile^, HashSize);

      CompressedData.CopyFrom(InData, InData.Size - InData.Position);

      GetHash(CompressedData.Memory, CompressedData.Size, Hash);

      if not CompareMem(Hash, HashFromFile, HashSize) then
      begin
        Result := UPF_HashChanged;
        Exit;
      end;
    finally
      FreeMem(Hash);
      FreeMem(HashFromFile);
    end;

    CompressedData.Seek(0, soFromBeginning);
    ZDecompressStream(CompressedData, OutData);

  finally
    if Assigned(CompressedData)
      then FreeAndNil(CompressedData);
  end;

end;

function CheckFile(InData: TStream; const FileHeaderSize: Integer): Boolean;
var
  Hash, HashFromFile: Pointer;
  CompressedData: TMemoryStream;
begin
  Result := False;

  if InData.Size>=FileHeaderSize + HashSize then
  begin
    CompressedData := nil;

    try
      InData.Seek(FileHeaderSize, soFromBeginning);

      CompressedData := TMemoryStream.Create;

      GetMem(Hash, HashSize);
      GetMem(HashFromFile, HashSize);

      try
        InData.ReadBuffer(HashFromFile^, HashSize);
        CompressedData.CopyFrom(InData, InData.Size - InData.Position);
        GetHash(CompressedData.Memory, CompressedData.Size, Hash);
        Result := CompareMem(Hash, HashFromFile, HashSize);
      finally
        FreeMem(Hash);
        FreeMem(HashFromFile);
      end;

    finally
      if Assigned(CompressedData)
        then FreeAndNil(CompressedData);
    end;
  end;
end;

end.
