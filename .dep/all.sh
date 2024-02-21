#!/bin/bash
rm /tmp/allpro 2>/dev/null
echo '#!/bin/bash' >> /tmp/allpro
curl -Ls github.com/uureel/batocera.pro | grep '<code>curl -L' | sed 1d | cut -d '>' -f2 | cut -d '<' -f1 | sed 's,-L,-Ls,g' >> /tmp/allpro
dos2unix /tmp/allpro 2>/dev/null
chmod 777 /tmp/allpro
bash /tmp/allpro
