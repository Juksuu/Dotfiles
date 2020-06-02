function find
  if [ count $argv = 1 ];
  then
    command find . -iname "*$argv*"
  else
    command find "$argv"
  end
end