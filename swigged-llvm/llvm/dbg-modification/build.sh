set -e
date
for f in `find {bindings,include,lib} -type f`
do
cp $f ../llvm/`echo $f | sed 's#^./##'`
done

