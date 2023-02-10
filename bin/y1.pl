import sys
import yaml

def _y1(configFile):
    with open(configFile) as f:
        conf = yaml.load(f)

    ret = {
        'http': {
            'listen': 80,
            'hosts': {},
            'forwards': {}
        }
    }

    ret['http']['listen'] = conf['http']['listen']

    for rule in conf['http']['rules']:
        if 'if' not in rule.keys():
            continue
        host = 'default'
        if 'host' in rule['if'].keys():
            host = rule['if']['host']
        if host not in ret['http']['hosts'].keys():
            ret['http']['hosts'][host] = []

        ret['http']['hosts'][host].append(rule)

        if 'then' not in rule.keys():
            continue
        if 'forward' not in rule['then'].keys():
            continue

        name = rule['then']['forward']['name']
        forward = {
            'targets': [],
            'stickiness': False
        }
        for t in rule['then']['forward']['targets']:
            forward['targets'].append(dict(t))
        forward['stickiness'] = rule['then']['forward']['stickiness']

        ret['http']['forwards'][name] = forward

    ym = yaml.dump(ret, Dumper=yaml.CDumper)
    print(ym)

if __name__ == '__main__':
    if (len(sys.argv) <= 1):
        print("Usage: y1.pl <config file>")
        sys.exit(-1)
    _y1(sys.argv[1])

