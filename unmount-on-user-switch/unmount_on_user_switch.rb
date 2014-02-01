#nombre del usuario actual
me = `whoami`.strip

#listado de 2 columnas, usuario y nombre de volumen
mounts = `ls -l /Volumes/ | sed -n '1!p' | awk '{print $3 ":" $9}'`.strip

#convierte listado en hash, clave de usuario, valor de nombre de volumen
mounts = Hash[*mounts.split("\n").map { |line| line.split(":") }.flatten]

#recorre el hash y desmonta volumenes q no pertenezcan al usuario o a root
mounts.each do |user, value|
  next if [me, 'root'].include? user
  `diskutil unmount /Volumes/#{value}`
end