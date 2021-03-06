#!/bin/sh
rm -rf /tmp/PSO2ENPatchCSV.outputPO
git archive --format=tar --prefix=PSO2ENPatchCSV.outputPO/JP/ upstream/JP | tar xf - -C /tmp
git archive --format=tar --prefix=PSO2ENPatchCSV.outputPO/EN/ upstream/EN | tar xf - -C /tmp
rsync -a . /tmp/PSO2ENPatchCSV.outputPO/WC/ --exclude ".git" --del
build="$(git describe --always)"
cd /tmp/PSO2ENPatchCSV.outputPO/WC/Files
find .. -name "*.csv" -not -path "../Files/*" -exec ln -s {} . \;
cd /tmp/PSO2ENPatchCSV.outputPO/EN/Files
find .. -name "*.csv" -not -path "../Files/*" -exec ln -s {} . \;
cd /tmp/PSO2ENPatchCSV.outputPO/
echo #, fuzzy
echo msgid \"\"
echo msgstr \"\"
echo \"Project-Id-Version: PSO2 CSV $build\"
echo \"MIME-Version: 1.0\"
echo \"Content-Type: text/plain\; charset=UTF-8\"
echo \"Content-Transfer-Encoding: 8bit\"
find JP -name "*.csv" -print0|sort -z|WC/_tools/mp.sh -0 WC/_py/outputPO.py
