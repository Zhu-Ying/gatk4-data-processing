
#!/bin/bash
cromwell_version="33"
wdl="processing-for-variant-discovery-gatk4.wdl"
json="processing-for-variant-discovery-gatk4.hg38.wgs.inputs.json"


# Sleep one minute between printouts, but don't zombie for more than two hours. This prevents Travis from automatically exiting due to lack of output while workflow is running.
for ((i=0; i < 180; i++)); do
    sleep 60
    printf "…"${i}
done &
#downloand cromwell
printf "Download cromwell "${cromwell_version}
wget -q http://github.com/broadinstitute/cromwell/releases/download/${cromwell_version}/cromwell-${cromwell_version}.jar
#excute wdl script
java -Dconfig.file=travis/resources/google-sac.conf -Dbackend.providers.JES.config.project=broad-dsde-outreach -Dbackend.providers.JES.config.root=gs://beri-test/gatk-workflows-travis-tests/ -jar cromwell-${cromwell_version}.jar run ${wdl} -i ${json};
