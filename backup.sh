BACKUP=`uname -n`

# put the backups in a good location.  "/tmp" is only an example 
mkdir -p /tmp/$BACKUP

 

# LVM info
pvs > /tmp/$BACKUP/pvs.out

vgs > /tmp/$BACKUP/vgs.out

lvs > /tmp/$BACKUP/lvs.out


# back up /apps directory.  These are only examples.  Change as you see fit.
tar cf /tmp/$BACKUP/apps.tar /apps

# back up /log
tar cf /tmp/$BACKUP/log.tar /log

# back up /mr
tar cf /tmp/$BACKUP/mr.tar /mr

# back up /home/guest
tar cf /tmp/$BACKUP/home-guest.tar /home/guest

# back up /home/Ronaldhino
tar cf /tmp/$BACKUP/home-Ronaldhino.tar /home/Ronaldhino

# back up /home/Batman
tar cf /tmp/$BACKUP/home-Batman.tar /home/Batman

# get NFS mounts
grep -i nfs /etc/fstab > /tmp/$BACKUP/NAS-MOUNTS

# copy entire fstab
cp /etc/fstab /tmp/$BACKUP
 
# get Ronaldhino's crontab
su - Ronaldhino -c 'crontab -l' > /tmp/$BACKUP/Ronaldhino.crontab

# get root crontab
crontab -l > /tmp/$BACKUP/root.crontab

# get the 3 IDs
egrep "guest|Ronaldhino|Batman" /etc/passwd > /tmp/$BACKUP/PASSWD
egrep "guest|Ronaldhino|Batman" /etc/shadow > /tmp/$BACKUP/SHADOW
egrep "guest|Ronaldhino|Batman" /etc/group > /tmp/$BACKUP/GROUP

#Make a directory called BACKUP
mkdir -p /BACKUP
#Mount a mount point called /backups/serverbackups on your current server and mount it to the new /BACKUP directory
mount a_backup_server.domain.com:/backups/serverbackups /BACKUP
#copy all data you backed up into the NAS mount.  That NAS mount can then be mounted to any other server where needed.
cp -r /tmp/$BACKUP /BACKUP

#sync to flush file system buffers
sync;sync;sync
#Cleanup backup mount from local server
umount /BACKUP
