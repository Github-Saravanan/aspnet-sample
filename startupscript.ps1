New-Item "C:\agent" -itemType Directory
cd "C:\agent"
$url = "https://dev.azure.com/WorldVisionUK"
$token = "7dby7dccvfzaarbexr55dz6btcmwmusu4wjsz76zygnvdjuewtha"
$pool="testcmscaleset-agent"
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$token"))
$package = Invoke-RestMethod "$url/_apis/distributedtask/packages/agent?platform=win-x64&$`top=1" -Headers @{Authorization = "Basic $auth"}
$fileName = $package.value[0].fileName;
$downloadUrl = $package.value[0].downloadUrl;
    
Invoke-WebRequest -UseBasicParsing $downloadUrl -OutFile agents.zip
Expand-Archive -Force agents.zip -DestinationPath .
Remove-Item -Force agents.zip
.\config.cmd --unattended --pool 'scaleset-agent' --url 'https://dev.azure.com/WorldVisionUK' --auth 'PAT' --token '7dby7dccvfzaarbexr55dz6btcmwmusu4wjsz76zygnvdjuewtha'



.\run.cmd