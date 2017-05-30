(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� aJ-Y �[o�0���Oa��K��P�eb�����֧($.x�&�Ҳ��}v� !a]�j�$�$�䜿o�'�7�4���5��{���n��Z��RȷI��3QE���\��.vD� ���R&�b� p+��i�k�����j��y�H�m�� x�[RIm� ����z"�"g�H��Zl7rʧ���4�f�)6B�R���a@��e  �~%\vd��g6䧘���� ����tm10}�OpڿQ��e2Z���;rn�Ԟ��kk"oZ��V+�6��Ģ��l��Mb6�7;�4gjf8Ԡ���:���	�p���F/���j�R��Hⷜ�87#�;)�h4��L.����b��G�W�}��f`���e�����x�^����smlܗ�J���B��(6K�;��O���}��ڷ$\����&W�j�Ua��#�\~�ʀ8�K&~��4p�F�J�|"��{����_�F�Z�	ߩ,�k�Z�٣^��|��6[Q�u2Su�Ł:��d�i� ������>�cz��H��]�䂂j���	-y�Ϸ<D��ű�A�MpȦ`»C`�m�������T���ܠ��r�8 ���<��s����M�C��-7*�����k
nEB��ࣂ/�j�؅]s�*kQJ�q�,+�RU�B7�~�pl�,Ē �D�O�*�
�����E!���)���,�_�(m����vz���ۿ�_�p8���p8���p8���p8�o��� (  