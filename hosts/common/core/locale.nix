######
## Locale Configurations  ##
######
{lib,...}: 

{

  # Set your time zone.'
  time.timeZone = lib.mkDefault "Africa/Tunis";
 

  # Select internationalisation properties.
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";


}
