
colorPrint() {
  text=$1
  printf "%b" "\e[1;34m${text}\e[0m"
}

replaceInFiles() {
    textToFind=$1
    textToPut=$2
    dir=$3

    for file in $(grep -Ril "$textToFind" $dir)
    do
        if [ -f "$file" ] && [[ "$file" != Files/Pods* ]]
        then
            sed -i '' "s+$textToFind+$textToPut+g" "$file"
        fi
    done
}

cd `dirname "$0"`
middleman build

# Files path fix for Github pages
replaceInFiles "/stylesheets/" "./stylesheets/" "../docs"
replaceInFiles "/javascripts/" "./javascripts/" "../docs"

colorPrint "\t🎉  Congradulations! 🎉\nDocuments was successfully generated!"
