#!/usr/bin/env python3

from socket import getfqdn
from pathlib import Path

verbose = 'v'
dry_run = 'n'

src_host = getfqdn()
src_dir = str(Path.home())
dest_host = 'hastur.oit.duke.edu'
dest_dir = '~/backup_from_{}'.format(src_host)

include_dirs = [ '.ICEauthority',
                 '.ansible',
                 '.atom',
                 '.bundle',
                 '.cache',
                 '.chrome',
                 '.config',
                 '.containers',
                 '.gem',
                 '.gimp-2.8',
                 '.gnome',
                 '.java',
                 '.local/lib',
                 '.local/share',
                 '.mozilla',
                 '.pEp',
                 '.pki',
                 '.rbenv',
                 '.wine',
                 '.zoom' ]

def main():

  print('rsync -az{}{} {} {}:{} --exclude=some_string'.format(
    verbose,
    dry_run,
    src_dir,
    dest_host,
    dest_dir))

  for i in include_dirs:
    print(i) 

main()
