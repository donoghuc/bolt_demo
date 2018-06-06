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

Write a task that shows off multiple task implementations

## multi_task.ps1
```
param ($message)
$result = @{"windows" = $message}
ConvertTo-Json -InputObject $result
```

## multi_task.sh
```
#!/usr/bin/env bash

cat <<JSON
{ "bash": "${PT_message}" }
JSON
```

## multi_task.json
```
{
  "implementations": [
    {"name": "multi_task.sh", "requirements": ["shell"]},
    {"name": "multi_task.ps1", "requirements": ["powershell"]}
  ]
}
```

## demo invocation
```
bolt task run demo::multi_task -n windows,linux --configfile /home/cas/working_dir/bolt_demo/bolt.yaml message="yay multitasking!"
```

## output/result
```
Started on x575vokuxtx5b6q.delivery.puppetlabs.net...
Started on t02hlpmgwicjtkh.delivery.puppetlabs.net...
Finished on t02hlpmgwicjtkh.delivery.puppetlabs.net:
  {
    "bash": "yay multitasking!"
  }
Finished on x575vokuxtx5b6q.delivery.puppetlabs.net:
  {
    "windows": "yay multitasking!"
  }
Successful on 2 nodes: x575vokuxtx5b6q.delivery.puppetlabs.net,t02hlpmgwicjtkh.delivery.puppetlabs.net
Ran on 2 nodes in 2.57 seconds

```

### Setup: PE install on vmpooler
```
Your VMs on vmpooler.delivery.puppetlabs.net:
- brqt2cu140grppu.delivery.puppetlabs.net (centos-7-x86_64, 24.09/36 hours, beaker_version: 3.34.0, department: unknown, project: Beaker, created_by: cas, name: centos7_agent, roles: agent, frictionless)
- xjslan4e8hxm6an.delivery.puppetlabs.net (redhat-7-x86_64, 24.09/36 hours, beaker_version: 3.34.0, department: unknown, project: Beaker, created_by: cas, name: rhel7_master_and_agent, roles: master, agent, database, dashboard, classifier, default)

```
## Setup: Get a windows and linux node for multitask
```
- t02hlpmgwicjtkh.delivery.puppetlabs.net (ubuntu-1604-x86_64, 3.64/12 hours)
- x575vokuxtx5b6q.delivery.puppetlabs.net (win-10-1511-x86_64, 0.61/12 hours)
```