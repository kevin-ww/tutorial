../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel


../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP


../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP


../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP

../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP


peer channel create -o orderer0.orgorderer1:7050 -c mychannel -f ./channel-artifacts/channel.tx


export CHANNEL_NAME=mychannel  &&

../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME


peer channel update -o orderer0.orgorderer1:7050 -c mychannel -f ./channel-artifacts/Org1MSPanchors.tx


peer chaincode install -n mycc -v 1.0 -p github.com/hyperledger/fabric/peer/channel-artifacts/chaincode_example02


peer chaincode instantiate -o orderer0.orgorderer1:7050 -C mychannel -n mycc -v 1.0 -c '{"Args":["init","a","100","b","200"]}'

peer chaincode invoke -o orderer0.orgorderer1:7050  -C $CHANNEL_NAME -n mycc -c '{"Args":["invoke","a","b","10"]}'
