{% set p  = salt['pillar.get']('intellij', {}) %}
{% set g  = salt['grains.get']('intellij', {}) %}

{%- set intellij_home   = salt['grains.get']('intellij_home', salt['pillar.get']('intellij_home', '/opt/intellij')) %}

{%- set year                 = g.get('year', p.get('year', '17' )) %}
{%- set release              = g.get('release', p.get('release','2' )) %}
{%- set mirror1              = 'https://download-cf.jetbrains.com/idea/' %}
{%- set mirror2              = 'https://download.jetbrains.com/idea/' %}

{%- set default_prefix       = '/usr/share/java' %}
{%- set default_source_url   = mirror1 + 'ideaIC-20' + year + '.' + release + '-no-jdk.tar.gz' %}

{% if salt['grains.get']('saltversioninfo') <= [2016, 11, 6] %}
   ######## version 2017.2 hash ######
   {%- set default_source_hash  = 'sha256=d88257b17447398ed60e7d774803cbc21e0fe7750add09622a98b936f14cd91f' %}
{% else %}
   {%- set default_source_hash  = mirror2 + 'ideaIC-20' + year + '.' + release + '-no-jdk.tar.gz' + '.sha256' %}
{% endif %}

{%- set default_dl_opts      = ' -s ' %}
{%- set default_real_home    = default_prefix + '/idea-IC-' + year + release %}
{%- set default_unpack_opts  = 'z -C ' + default_real_home + ' --strip-components=1' %}
{%- set default_archive_type = 'tar' %}

{%- set default_archive_type = 'tar' %}
{%- set default_symlink      = '/usr/bin/idea.sh' %}
{%- set default_realcmd      = default_real_home + '/bin/idea.sh' %}
{%- set default_alt_priority = '30' %}         

{%- set source_url           = g.get('source_url', p.get('source_url', default_source_url )) %}
{%- if source_url == default_source_url %}
  {%- set source_hash        = default_source_hash %}
{%- else %}
  {%- set source_hash        = g.get('source_hash', p.get('source_hash', default_source_hash )) %}
{%- endif %}

{%- set prefix               = g.get('prefix', p.get('prefix', default_prefix )) %}
{%- set intellij_real_home   = g.get('realhome', p.get('realhome', default_real_home )) %}
{%- set dl_opts              = g.get('dl_opts', p.get('dl_opts', default_dl_opts)) %}
{%- set unpack_opts          = g.get('unpack_opts', p.get('unpack_opts', default_unpack_opts)) %}
{%- set archive_type         = g.get('archive_type', p.get('archive_type', default_archive_type )) %}
{%- set intellij_symlink     = g.get('intellij_symlink', p.get('intellij_symlink', default_symlink )) %}
{%- set intellij_realcmd     = g.get('intellij_realcmd', p.get('intellij_realcmd', default_realcmd )) %}
{%- set alt_priority         = g.get('alt_priority', p.get('alt_priority', default_alt_priority )) %}

{%- set intellij = {} %}
{%- do intellij.update( { 'year'               : year,
                          'release'            : release,
                          'source_url'         : source_url,
                          'source_hash'        : source_hash,
                          'intellij_home'      : intellij_home,
                          'dl_opts'            : dl_opts,
                          'unpack_opts'        : unpack_opts,
                          'archive_type'       : archive_type,
                          'prefix'             : prefix,
                          'intellij_real_home' : intellij_real_home,
                          'intellij_symlink'   : intellij_symlink,
                          'intellij_realcmd'   : intellij_realcmd,
                          'alt_priority'       : alt_priority,
                     }) %}
