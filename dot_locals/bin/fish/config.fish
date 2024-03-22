if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_hostname rahul
    set fish_greeting
    set JAVA_HOME /usr/lib/jvm/java-8-openjdk/ 
    set JRE_HOME /usr/lib/jvm/java-8-openjdk/jre 
    set MOAUTH_ENCRYPTION_KEY aeLjKOU0F3 
end


function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
