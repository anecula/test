# Requied to install boto3, by pip install boto3

import datetime
import boto3
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--days', type=int, default=30)
args = parser.parse_args()

now = datetime.datetime.utcnow()
START = (now - datetime.timedelta(days=args.days)).strftime('%Y-%m-%d')
END = now.strftime('%Y-%m-%d')

# Region
client = boto3.client('ce', 'eu-west-1')

# Filter by TAG that used by ansible ec2
result = client.get_cost_and_usage(
    TimePeriod={"Start": START, "End": END},
    Granularity="MONTHLY",
    Metrics=["UnblendedCost"],Filter={"Tags": { "Key": "PROVIDEDBY", "Values": ["ANSIBLE"] } }
)

print("Total spend from {} to {} is {} USD".format(
    START, END, result['ResultsByTime'][0]['Total']['UnblendedCost']['Amount']))
