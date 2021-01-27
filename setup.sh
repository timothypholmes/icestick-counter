#!/bin/bash

# input args desc
print_usage() {
	printf "
  Example usage: 
    ./setup.sh [-u USERNAME] [-a IPADDRESS] [-v] [-h]
  
  Flags:
    -u, username      Username of remote machine.
    -a, ip address    IP address of remote machine.
    -v, verbose       Run script in verbose mode. 
    -h, help          Display help.
  "
}

# input args
user=''
addr=''
verbose=false
while getopts ':u:a:vh' flag; 
do
  case "${flag}" in
    u) user="$OPTARG" ;;
    a) addr="${OPTARG}" ;;
    v) verbose=true;;
    h) print_usage;
       exit 1 ;;
  esac
done

# Default options if no input args entered
if (( $OPTIND == 1 )); then
   print_usage
   exit 1
fi

printf "USER: $user \n"
printf "ADDR: $addr \n"

# copy raspberry pi files over
printf "coping rpi dir to raspberry pi\n"
printf "===============================\n"
if [ "$verbose" = true ]; then
  scp -r ./rpi $user@$addr:.
else
  scp -qr ./rpi $user@$addr:.
fi

# create ssh connection to pi
file=./pi_connect.sh
if [ -f "$file" ]; then
  printf "$file already exists.\n"
else 
	printf "Creating connect file here.\n"
  printf "===========================\n"

cat > pi_connect.sh << EOF
    #!/bin/bash
    ssh -t $user@$addr '(cd ./rpi && make); bash -l'	
EOF
  chmod +x pi_connect.sh
  ./pi_connect.sh
fi