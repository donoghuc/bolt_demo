plan demo::pdb_discover {
  $query_result = puppetdb_query("nodes[certname] {}")
  $nodes = $query_result.map |$r| { $r["certname"] }
  return run_task(apply::resource, $nodes, type => 'package', title => 'vim', params => {'ensure' => 'present'})
}