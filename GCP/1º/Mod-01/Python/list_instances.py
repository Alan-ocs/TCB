from googleapiclient import discovery
from googleapiclient import errors

import sys

project="SEUPROJETO"
zone="us-east1-b"

compute = discovery.build('compute', 'v1')
instances = compute.instances().list(project=project, zone=zone).execute()

print(instances['items'][0]['name'])
