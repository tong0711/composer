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
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� aJ-Y �]Ys⺶����y�����U]u�	�`c�֭�g&cc~�1��3t҉w�j]�$dYKZ�ZbI��>Y�Wn��!�ח )@����$��z��PEq� H�H/^��_5�k���lm���_���N��˽��/��H����4��Ӄ�����SF���h��_ޒ�m
�+�b�c�Q������|�Aup��Q� *������W\������O���/�$�����q�1.�?I�x%�2p_��ۉ�ag���=��
�~'�'�B�c����$]�����������ro��K�9�Fhsp�<��)�r	�i�)�!	�\�(!�i�d0�v<�tQ�	�&���W�u�!������?N���?^|��������:��Zy�j=]6�!�ڢuʃ���Me�w٤�0	���
V�ׂ���ikA�*̄Բ�O�4q��W��B���f<�-�x�X��I�	ܑ�㹉�S�z�B4�Y��|��,=�N�R7��@��4}������@�e����E/�P׾�N�U����;�7�/�ۋ�K�Oׯ;���TaV�_�,��e\�^'~��o�������@*�_
�^�Y��Bm�j~Y����\�@(k�R�Y��2C�gͥ�m-��0\M�nO�0�BE�r��,�Դ�����A4��F �<��5L���x�Fdb�P�S�S�&mdq���!9�G��9����'��6̅;g�ヸ��B��b�Mn1�zn���A�!⊠���z�ŌG�!i�^=ܧ� v0?�`����Сs͡��Չ�XD���Cq'������Y�M��I[,��oā�q�t1�S�b>��Cso୥bpc�S��L� O
��
p�����yxsh���H"S�n$L�^�[\c�ƨ��s��/;hS@�N��䒡ʅ�ʻ�R�L�ŭ�L�f�E�F�S q|~O�E�5�(�dz�>h���@���kp+O<��p `��Q�:��xY���"cR��M����� ��z`m:�������}�\)L�B�<@B��^�x�:tr �	>��-�F\Ę�2�`���>;��ߵs9䖓�%���D�b�ՇL�@�"=�cш�̢O�Q��>,>0���zf��_���4|���Q���R�I����x��ѧ���Y�x���Y��Nt��:PC��f{��W�d�%��'�s>��v<�3�H'B�~ƨ�*�3F}?��rd��A��`� �EZ��`����4E�w���7��0EWrH<�0��'�5�%��;�b��V.�S^S�Q���lM�HM\L���C�f�?�e�.�i���ռ���ž�@h]�.?���gN�ȅ�D�=�5af[8�ȑ�[���9k@@H\^d��!��
 y;?U2�x-�cb��a�59p�k9�;�u]�����f�ڔ�Q"��0~:h=��E�Fѥ>��6s0!����8N�H�YD��M��_��~a(�v�7�6cyb|�M����u-�WS�ͬ��C��db<�?�/��~������?J����5������E�����������s�_���	������������2����JA�S�����'}�p�/�l��:N�l��a��a���]sY��(?pQ2@1g=ҫ��)�!�7�����P^�e������qG��V�4��e��,��h\�o����b��Z6�`۶�17�ij��ɗ޲���f�V_r̹�4p�N�#ڃ967�hk�� ����V��(A��f)�Ӱ���(~i�e�O�_
>K����T��T���_��W��}H�e�O�������(�S�*���/�gz����C��!|��l����;�f���w�бY��G�Ǧ��|h ���N���p\�� ��I��!&��{SinM�	����0w�s��t��$��P�s��m6�7�y�ֻ� 
�4%
��<.&�R��;Y�c���'Zט#m�G��lp�H:����9:'�8���c� N��9`H΁ ҳm��-LC^���Νp�n��3Զ��$tpaA�ܠ�w�=Ο��={2hBU'���F�����z�_@�I���u���N�,�Ҳ��h�����j*8���1���Y��e�$d��9Ɋ�����O�K��+�Њ������+�*�/��_�������������#�.�A+�/�����?F�x��������+��s��w��C�Ƕ@A�����*���q	�{�M:x�������Юoh�a8�zn��(°J",�8, �Ϣ4K��]E��~(C����!4AU�_� �Oe®ȯV+U���؜����=�i�m����?��)���H�	�S����;����^����=��n�c�Vi�ہ�8"��	�y� ���`�ʇ7y��)%�v�Y��a<��q�������D��_�!��<��?Tu�w9�P���/S
��'�j������A��˗����q��_>S�/m�X��k���[
~��G�������2�%��p�Y�X�ql�t�b)��(�s	��l<!p�u<�Y�	ǷY���j��4�!���p�x�S�����`�����x�����	���m,� �r�+�5�D�|����j@.�l�uw�9��+>��z*�F��Qc&�:e^3�Z������p�i�a��3���}m�`�`f���χ�����������J��`��$�����������ٗFU(e���%ȧ���U��P
ފ�j�<���ϝ���k�KX0�}C~v��x���?K�ߟ����q�����r1��Zo�H_������~�9���9���A�=zд�æ�[&N>��)��/��#݅����A�o�վml�8O`���L�z��"<c8x&'8�d�ub�ysD�������⢹���l�LT0�:����=�m�(����1��&1`[���&�0�BK<��9ޭ�+�F��5a��7�STY�M9�S�Kw*�vg<6� n-�y��<�K�In{.���}�?�� �'�)gSs��wu��{
mE6��l�q�s�2�)a�l�i��@�=��a�Sb3�=)�h���g�O�֪�Ys�P��ϋ�L���v���8^���෰�)����!|���In���(C�o�����%���/���ѿ��1nۯ�x7w��i*�;<��}���{C��<3���#� ����} �'�@���-��) ��i����1^9zp Dbl'�����>���$���ld�l�k��e+=5%���ʱkiBÐNe3&ɜ��ep*7<��k����q�W��[�A@O�x�ygs���l��f��9r5��Z�lޥ�ݴo���<k$���Ž������Z�-Xr�\���������i4l����BEا���<{�)>S��t���?B�U�_)�-��Y�G���$|�����=(C�Z��+��T������_���S������@��ϥ�r�_n�]���PU�g)��������\��-�(���O��o��r�'<¦iCI�b�d	��}�H�'p&@�vq�Q�!֧���u1�a0�:�B������/$U������ �eJ���-sjư���S�m�m+[,�Fi�5yq��1��t�V�֕�FwGѽdMq=�o{;�cF��sh}�
��A~
ӻ�N���r���)�2�Q_��,6��y����bw�����8���������G�����E���*[?�
-���7�7e~���~���\9^j�id����d������b:��N�+���c���B��k��^$������2��s%��UM�.�7<�iv�;�]���^�᧧&q��~��!�o�?�9�7��޷Z6�]�����Q;�w]�*R����t��޼���~,t�+���������jWN������o��]��N]�����G��%��}{�S���rmO�~z���bT���]ePQ��V�9O��1�n�]4��� �~�UQ����7D�.��ߑ�ӿK�}���F�+|?��������>w�z��8N����Q��E�g_nl��ߓ�����7o�d�y�,�3�^����o���:b��"{�a�%o�� ��w[/�������y��N���ͷWkӻ]�����zU������3�X��O[ �����SS�8�O��7M���8Y�a���	��.Nד�s]���L�GR��j�h�B"GE��L	����}7@�����,n{�柫�S���X�"��wu�oY廂x#�D~`����݁�=Z �˪����N7��dS)���ʪ�}����0<��5��S8�,�%u�=��O��b�S���]m��d���rx.\%�� �1����뺗�u�麭{ߔ\{���֭=�މ	jBL0�%h�$h�����~R�4��H���#
1Q?�m��lg�9;����M�����ҧ��������<��7{I/6�Θ#���ܔ�A	���]!�,�L��H
�FÃ�xA�H2���.%ӑx׭mY;&�:z��"���2�N�q���ʹ�fet,����D�y�'����6!�v1a\ȇm�wTeI�{:884��6�����D�8�����[f&M7�� �Z-�m����L�,��V4]7um����8cg֫���;�$(�>��Lv�C�-d�4E��q	�
_e;R���,�7�h}0�׌3�U�=4��H�̪��5Π˰Ѳ��f�����!�PZ����YG�W�VE��{���Y^�M��h�|��t��o�t�M�)r8]�ɆSN���98�������trb��;�G�_'W�A���EEb�*wZ�E�}��\���c��j���e�u���_�2�&�t*i��H�s�ou�C֑�����sFO�T�x֜��H�2�4ҹ�+�5�o��2�+Q�5N�)F�`t������Շ��|m]p\r����T��2��c����M�z�b����\4([�(E������@]�9�Z�+7��9��ˑ~�S{����|U2�-�
�ÍF1���|vϹ����$�B��ɏ9)�:b!Cf<�Kp���:��2b�f�mN�4��޴��tx��Kǧ�}�a�+#��U{I6ta-*���B��.dy��>G����89���U�t?�}��C�y�(�sy�`�؟O>��{��w������Qc����?��������O��8x�Nl�Z{�ߏ��j絖J\x`���.��@�`,��E�U�uc�^�G�׳��V]����*���#��C9=�����Cgoo�vǙ_���ح��wO<����ڥG��9�
<C��J7����9�5�@8�C'��� ��š����9p�q��9���'��\���H�A���>=�Ծ�_���d}����Y�<0"�Ὠ�%�,ף��m��$^�0{����� ��a���6���e�z�����`#G$7C�6�%�n�3�,�Q��!�n�_��[��!��L��P;e��k`�4��Wɝ.��i2_�Q,S�׃���l���A�#pF��Ɇn�R�$�l����0GaJ����&j|?Mg��hG�X�)�A�/�����,
�L:;�+��f�(�ȄT*{j�l�G	�F)/�0,��-!&$=���,$�������C|��Ԕ'��z)D�!X.�G>e3am&�̈́]�	=} �n����E��Ԧ�:�Z�z�C�kvzK�.�����JȺUq0���h��d#n<(owœ�LR�n��2W��p_�#^���2A4�'Q��o5z��	%�L��6��|B"��CV�v�4�.�`�A"ԎdX��������+�CV�ل��l����A�
Amk�r<B�S�H��j���q�d%�U:�>�v�j�����D�@�)�apw=��cLd�m4�}e	��,ـuFY�ܙ�\w@
d���p*%����N488�������g�V4�v��6����P>�S-�IqJt���/B��ʠ
����g$:�%*B��*�h��1y<ӒRsʲGxFv��DU��h�7$	����V��9�`W'���p�I�8b*�`X-�;Q����J%#5?�k2�|�PM�}����
�ﭲ�)K����W��
�Ec=��|���Q�t�Y $(q����;)t�Z3�]���_I�|/5,��q%Z��vr�İR�������HLj�	 '܇S����I�A��j�,��7¤\�L�c�9e�#<#�TY��&��0��Ū�>-�T�{�,�+�k�%��7�p�9D���I��ɾ�T�6!�}�B�3#٤Ȗ#� ��$�����8m����l�m5�m�n�4'
�)��6�j�G�skWB�tJ�{b튍3�uӯ�V&A �.{�T�u��t��+��J�l�PUm���mN4B�r��]�v{]M���!T�����7�n�n7��+m\�F'7�7��B���j����AkSU]O�g���Ѳ��֡S�&K�%�ך��Ԇ<t3tz�?��s�هvX��:�,tf�*L~���d.��0�J���r��z]�Z�qL�gu�%3>1-3y��ʁ�;N㊢�Ũ�g�C/CF`Ō�C�C�.��DY5>�i�: �ڌ��?�#�_�[�ȍ������[����w˳_
엂�_
?p�-<���[$��3�.V�|+���le��}�AK	����Xt0�梃Ѡd�AO���`iς�Gu��I���iL7k� �=�w�{�1��7=4E��!�)5�Eҫz؈�EX)�E�@8R����hőh��~����WH�n!8�Ŕ�h^wn�u:�q%_�8Vh�c�rhd�:�����ᑠ�6���ӘI��ݣ&�C�±DM�05:D��g���ꪷC�fj9�i�:F��|>��O(�*q�2��T�q6�AZ��se�u�7�76���6D;�O�bB�%�[$��yյn��i
�$u�-��r�ǥ�V�c<��q8m㰍�6��X׮�t7t��T�2�\�6���c2�c�3���<�{�;t�[�2\��2����}���^���1�������ܗ�ò#i�Hڪ�Hf*8�6J�J)7p�K2�:�e؜�|�����b�KQ���`��>��D�Q�"�V�QPd�YS�՟c�w��Fm*	LL);q1D�A0�L��Ni��r&��tP8��Ѳ��/+]n�4��������/
�K)	�bB8Z��썅��Cvc!D����A���0!RcKM���pp�(O���nAy��._ڙ�+�Ŷ;"��|��R<���Byq�Y&�P�l�3� BW��B{���Ė��9@7Y����R.��t���V/�¾K;��a��a���q��q�F�Vr�܇v�fr��Z)$�B�m�"��ۅ�6e5��2m�õ;�-\���n�_G4�JE�5���^�\?���σ�q��$��-�M����Lw{}�\�W�Mҟ�I�t���^���G~��V�;>��/륧��]_z�/���q�Zc?�������f�ٴp��1�q ���]������%���g����Ko��� �x���M|󦿾��W�? z�$��8x*�~p�ڕޯ��䊞n��h:Q�m@g߈��O~�/6~'����_/��׿�'��)�����4E�|�	�9K�|զv��N��i�l��M����߿��i; mS;mj�M��}6�g{?P;ͷ��|�� U�B����z��&�&�A�-"�N21����L��1��=��_��^��&��<ۭ�y��T�S��3���6���gp��X���`9_�MM�Y�i�sf�h�=gƞ`O�����a�e�3s���G�s9f�\8�0�!Bk��6�]��1�9��_ju��b��Nv������M��H�  