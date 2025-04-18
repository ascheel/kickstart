duo ()
{
    shopt -s dotglob;
    du -skx * | sort -k1,1n | awk '{if ($1>1024**2) $1=$1/1024**2 "G"; else if ($1>1024) $1=$1/1024 "M"; else $1=$1 "K"; print}';
    shopt -u dotglob
}

