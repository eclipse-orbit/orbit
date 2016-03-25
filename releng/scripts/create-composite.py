#!/usr/bin/python
# -----------------------------------------------------------------
# Script creating an Orbit composite p2 repository containing both the
# old style and new style recipe-based p2 repositories
#
# The following environment variables need to be set for this script
# BUILD_LABEL: N (nightly), I (integration), or R (recommended)
# ORBIT_OLD_LOCATION: relative path to old style Orbit repository
# ORBIT_NEW_LOCATION: relative path to new style recipe-based Orbit repository
# -----------------------------------------------------------------
import datetime, os, sys

def getVariable(name):
    try:
        value = os.environ[name]
    except KeyError:
        value = None
    return value

def makeDirs(dir):
    try:
        os.makedirs(dir)
    except OSError, e:
        if e.errno != errno.EEXIST:
            raise

def writeFile(path, content):
    file = open(path, 'w')
    file.write(content)
    file.close()

def main(argv):
    ROOT_DIR = '/home/data/httpd/download.eclipse.org/tools/orbit/'
    ARTIFACT_TEMPLATE = """<?xml version='1.0' encoding='UTF-8'?>
<?compositeArtifactRepository version='1.0.0'?>
<repository name='Eclipse Orbit Composite Site {build}'
    type='org.eclipse.equinox.internal.p2.artifact.repository.CompositeArtifactRepository' version='1.0.0'>
  <properties size='1'>
    <property name='p2.timestamp' value='{timestamp}'/>
  </properties>
  <children size='2'>
    <child location='{orbitOldLocation}'/>
    <child location='{orbitNewLocation}'/>
  </children>
</repository>
"""
    METADATA_TEMPLATE = """<?xml version='1.0' encoding='UTF-8'?>
<?compositeMetadataRepository version='1.0.0'?>
<repository name='Eclipse Orbit Composite Site {build}'
    type='org.eclipse.equinox.internal.p2.metadata.repository.CompositeMetadataRepository' version='1.0.0'>
  <properties size='1'>
    <property name='p2.timestamp' value='{timestamp}'/>
  </properties>
  <children size='2'>
    <child location='{orbitOldLocation}'/>
    <child location='{orbitNewLocation}'/>
  </children>
</repository>
"""
    P2_INDEX = """version = 1
metadata.repository.factory.order = compositeContent.xml,\!
artifact.repository.factory.order = compositeArtifacts.xml,\!
"""

    buildLabel = getVariable('BUILD_LABEL')
    if not buildLabel or buildLabel not in ['N', 'I', 'R']:
        sys.exit('variable BUILD_LABEL must be "N" (nightly), "I" (integration), or "R" (recommended)')

    orbitOldLocation = getVariable('ORBIT_OLD_LOCATION')
    if not orbitOldLocation:
        sys.exit('variable ORBIT_OLD_LOCATION is undefined')

    orbitNewLocation = getVariable('ORBIT_NEW_LOCATION')
    if not orbitNewLocation:
        sys.exit('variable ORBIT_NEW_LOCATION is undefined')

    buildTimestamp = datetime.datetime.utcnow().strftime('%Y%m%d%H%M')
    build = buildLabel + buildTimestamp
    destination = ROOT_DIR + buildLabel + '-builds/'+ build
    makeDirs(destination)

    writeFile(destination + '/compositeArtifact.xml',
        ARTIFACT_TEMPLATE.format(build = build, timestamp = buildTimestamp,
            orbitOldLocation = orbitOldLocation, orbitNewLocation = orbitNewLocation))
    writeFile(destination + '/compositeMetadata.xml',
        METADATA_TEMPLATE.format(build = build, timestamp = buildTimestamp,
            orbitOldLocation = orbitOldLocation, orbitNewLocation = orbitNewLocation))
    writeFile(destination + '/p2.index', P2_INDEX)
    print 'Created composite p2 repository in {0}'.format(destination)

if __name__ == "__main__":
    main(sys.argv[1:])
