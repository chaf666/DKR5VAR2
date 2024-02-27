Program dkr5;
var
  arr: array of integer;
  i, j, count, ram, c, m, len, max, id_max: integer;
  f, answer : text;
function MaxNumber(arr: array of integer): integer;
var
  i, max: integer;
begin
  max := arr[0];
  for i := 1 to Length(arr) - 1 do
  begin
    if arr[i] > max then
      max := arr[i];
  end;
  Result := max;
end;
procedure RadixSort(var arr: array of integer);
var
  i, j, digit, maxNum, currentDigit, divisor: integer;
  buckets: array[0..9] of array of integer;
begin
  maxNum := MaxNumber(arr);
  currentDigit := 1;
  
  while maxNum / currentDigit > 0 do
  begin
    for i := 0 to 9 do
      SetLength(buckets[i], 0);
      
    for i := 0 to Length(arr) - 1 do
    begin
      digit := (arr[i] div currentDigit) mod 10;
      SetLength(buckets[digit], Length(buckets[digit]) + 1);
      buckets[digit][Length(buckets[digit]) - 1] := arr[i];
    end;
    j := 0;
    for i := 0 to 9 do
    begin
      for digit := 0 to Length(buckets[i]) - 1 do
      begin
        arr[j] := buckets[i][digit];
        j := j + 1;
      end;
    end;
    currentDigit := currentDigit * 10;
  end;
end;
begin
  writeln('1 - Алгоритм выбором');
  writeln('2 - Поразрядный алгоритм');
  writeln('Введите сортировку:');
  while true do begin
    read(c);
    if (c > 0) and (c < 3) then break else writeln('Неверный ввод, повторите');
  end;
  assign(f, 'test1.txt');
  reset(f);
  count := 0;
  while not eof(f) do begin
    setlength(arr, count + 1);
    readln(f, ram);
    arr[count] := ram;
    inc(count);
  end;
  close(f);
  case c of
  1:
    begin
      len:=length(arr)-1;   
      j := len;
      while j > 0 do begin
          max := arr[0];
          id_max := 0;
          for i := 1 to j do
              if arr[i] > max then begin
                  max := arr[i];
                  id_max := i;
              end;
          arr[id_max] := arr[j];
          arr[j] := max;
          j := j - 1
      end;
    end;
  2:
    RadixSort(arr);
  end;
  writeln('Отсортировано в файл answer.txt: ');
  assign(answer, 'answer.txt');
  rewrite(answer);
  for i:=0 to length(arr) - 1 do
    write(answer, arr[i]+' ');
  answer.Close();
end.