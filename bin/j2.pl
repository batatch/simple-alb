import sys
import yaml
from jinja2 import Template, Environment, FileSystemLoader

def _j2(templateFile, configFile):
    env = Environment(loader=FileSystemLoader('.', encoding='utf_8'))
    tpl = env.get_template(templateFile)

    with open(configFile) as f:
        conf = yaml.load(f)

    ret = tpl.render(conf)
    print(ret)

if __name__ == '__main__':
    if (len(sys.argv) <= 2):
        print("Usage: j2.pl <template file> <config file>")
        sys.exit(-1)
    _j2(sys.argv[1], sys.argv[2])

