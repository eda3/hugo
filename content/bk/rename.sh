find ./*/ -type f -name "*.md" | xargs -I{} grep "^title" {} | tr -d "title: " > rename.txt
