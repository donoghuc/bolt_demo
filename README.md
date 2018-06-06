# Bolt Demo Proposal

Write a plan that shows off apply::resource as well as pdb_query

## plan: pdb_discover

```puppet
plan demo::pdb_discover {
  $query_result = puppetdb_query("nodes[certname] {}")
  $nodes = $query_result.map |$r| { $r["certname"] }
  return run_task(apply::resource, $nodes, type => 'package', title => 'vim', params => {'ensure' => 'present'})
}
```
## demo invocation

```
bolt plan run demo::pdb_discover --configfile /home/cas/working_dir/demo/bolt.yaml 
```
## output/result
```
Starting: task apply::resource on brqt2cu140grppu.delivery.puppetlabs.net, xjslan4e8hxm6an.delivery.puppetlabs.net
Finished: task apply::resource with 0 failures in 2.39 sec
[
  {
    "node": "brqt2cu140grppu.delivery.puppetlabs.net",
    "status": "success",
    "result": {
      "type": "package",
      "title": "vim",
      "changed": false
    }
  },
  {
    "node": "xjslan4e8hxm6an.delivery.puppetlabs.net",
    "status": "success",
    "result": {
      "type": "package",
      "title": "vim",
      "changed": false
    }
  }
]

```

### Setup: PE install on vmpooler
```
Your VMs on vmpooler.delivery.puppetlabs.net:
- brqt2cu140grppu.delivery.puppetlabs.net (centos-7-x86_64, 24.09/36 hours, beaker_version: 3.34.0, department: unknown, project: Beaker, created_by: cas, name: centos7_agent, roles: agent, frictionless)
- xjslan4e8hxm6an.delivery.puppetlabs.net (redhat-7-x86_64, 24.09/36 hours, beaker_version: 3.34.0, department: unknown, project: Beaker, created_by: cas, name: rhel7_master_and_agent, roles: master, agent, database, dashboard, classifier, default)

```
### Install puppetlabs/apply
https://forge.puppet.com/puppetlabs/apply/readme#usage
```
cas@cas-ThinkPad-T460p:~/.puppetlabs/task-modules$ r10k puppetfile install ./Puppetfile
```