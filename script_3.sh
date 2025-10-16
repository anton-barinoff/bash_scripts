read -p "Введите директорию для архивации" 
date=$(date +%Y%m%d)
archive_name="archive_${date}.tar.gz"
tar -czf "$archive_name" "$path"
echo "Архив создан: $archive_name"
