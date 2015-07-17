class InstallSomeContribPackages < ActiveRecord::Migration
  execute "CREATE EXTENSION pg_trgm;"
end
