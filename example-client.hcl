
# -------------- General options ---------------

# Specifies the region the Nomad agent is a member of. A region typically maps to a
# geographic region, for example USA, with potentially multiple zones, which map to 
# datacenters such as us-west and us-east. Defaults to global.
region = "USA"

# Datacenter of the local agent. All members of a datacenter should share a local 
# LAN connection. Defaults to dc1.
datacenter = "data-center-one"

# The name of the local node. This value is used to identify individual nodes in a
# given datacenter and must be unique per-datacenter. By default this is set to the
# local host's name.
name = "client-one"

# A local directory used to store agent state. Client nodes use this directory by
# default to store temporary allocation data as well as cluster information. Server
# nodes use this directory to store cluster state, including the replicated log and
# snapshot data. This option is required to start the Nomad agent. 
data_dir = "/tmp/nomad"

# Controls the verbosity of logs the Nomad agent will output. Valid log levels include
# WARN, INFO, or DEBUG in increasing order of verbosity. Defaults to INFO. 
log_level = "DEBUG"

# Used to indicate which address the Nomad agent should bind to for network services, 
# including the HTTP interface as well as the internal gossip protocol and RPC mechanism.
# This should be specified in IP format, and can be used to easily bind all network services
# to the same address. It is also possible to bind the individual services to different
# addresses using the addresses configuration option. Defaults to the local loopback
#  address 127.0.0.1.
bind_addr = "127.0.0.1"

# Enables the debugging HTTP endpoints. These endpoints can be used with profiling tools
# to dump diagnostic information about Nomad's internals. It is not recommended to leave
# this enabled in production environments. Defaults to false.
enable_debug = false

# Controls the network ports used for different services required by the Nomad agent.
ports {
    # The port used to run the HTTP server. Applies to both client and server nodes. Defaults to 4646.
    http = 4747
    
    # The port used for internal RPC communication between agents and servers, and for inter-server
    # traffic for the consensus algorithm (raft). Defaults to 4647. Only used on server nodes. 
    rpc = 4647

    # The port used for the gossip protocol for cluster membership. Both TCP and UDP should be routable
    # between the server nodes on this port. Defaults to 4648. Only used on server nodes. 
    serf = 4648
}

# Controls the bind address for individual network services. Any values configured in this block
#  take precedence over the default bind_addr.
addresses {

    # The address the HTTP server is bound to. This is the most common bind address to change.
    # Applies to both clients and servers. 
#   http = "0.0.0.0"

    # The address to bind the internal RPC interfaces to. Should be exposed only to other cluster
    #  members if possible. Used only on server nodes, but must be accessible from all agents. 
#   rpc = "0.0.0.0"

    # The address used to bind the gossip layer to. Both a TCP and UDP listener will be exposed on this
    # address. Should be restricted to only server nodes from the same datacenter if possible.
    # Used only on server nodes. 
#   serf = "0.0.0.0"
}

# Controls the advertise address for individual network services. This can be used to advertise a
# different address to the peers of a server node to support more complex network configurations such
# as NAT. This configuration is optional, and defaults to the bind address of the specific network
# service if it is not provided. This configuration is only applicable on server nodes.
advertise {

    # The address to advertise for the RPC interface. This address should be reachable by all of
    # the agents in the cluster. 
#   rpc = "1.2.3.4:4647"

    # The address advertised for the gossip layer. This address must be reachable from all server nodes.
    #  It is not required that clients can reach this address. 
#   serf = "1.2.3.4:4648"
}

# Used to control how the Nomad agent exposes telemetry data to external metrics collection servers.
telemetry {
    # Address of a statsite server to forward metrics data to.
#   statsite_address = "1.2.3.4:5678"

    # Address of a statsd server to forward metrics to.
#   statsd_address = "1.2.3.4:5678"

    # A boolean indicating if gauge values should not be prefixed with the local hostname.
#   disable_hostname  = false 
}

# Enables gracefully leaving when receiving the interrupt signal. By default, the agent will
# exit forcefully on any signal.
leave_on_interrupt = false

# Enables gracefully leaving when receiving the terminate signal. By default, the agent will
# exit forcefully on any signal. 
leave_on_terminate = false

# Enables logging to syslog. This option only works on Unix based systems.
enable_syslog = false

# Controls the syslog facility that is used. By default, LOCAL0 will be used. This should
# be used with enable_syslog.
syslog_facility = "LOCAL0"

# Disables automatic checking for security bulletins and new version releases.
disable_update_check = true

# Disables providing an anonymous signature for de-duplication with the update check.
disable_anonymous_signature = false

# ------------- server-specific options ----------------------------- 
server {

    # A boolean indicating if server mode should be enabled for the local agent. All other server
    # options depend on this value being set. Defaults to false. 
    enabled = false

    # This is an integer representing the number of server nodes to wait for before bootstrapping. It is most
    # common to use the odd-numbered integers 3 or 5 for this value, depending on the cluster size. A value of
    # 1 does not provide any fault tolerance and is not recommended for production use cases.  
#   bootstrap_expect = 3

    # This is the data directory used for server-specific data, including the replicated log. By default, this
    # directory lives inside of the data_dir in the "server" sub-path. 
#   data_dir = "/tmp/server"

    # The Nomad protocol version spoken when communicating with other Nomad servers. This value is typically not
    # required as the agent internally knows the latest version, but may be useful in some upgrade scenarios. 
#   protocol_version = 0

    # The number of parallel scheduler threads to run. This can be as many as one per core, or 0 to disallow this
    # server from making any scheduling decisions. This defaults to the number of CPU cores.
#   num_schedulers = 1

    # This is an array of strings indicating which sub-schedulers this server will handle. This can be used to
    # restrict the evaluations that worker threads will dequeue for processing. This defaults to all available schedulers. 
#   enabled_schedulers = "[]"

    # This is a string with a unit suffix, such as "300ms", "1.5h" or "25m". Valid time units are "ns",
    # "us" (or "µs"), "ms", "s", "m", "h". Controls how long a node must be in a terminal state before it is
    # garbage collected and purged from the system. 
    node_gc_threshold = "6h"

    # When provided, Nomad will ignore a previous leave and attempt to rejoin the cluster when starting.
    # By default, Nomad treats leave as a permanent intent and does not attempt to join the cluster again when
    # starting. This flag allows the previous state to be used to rejoin the cluster. 
    rejoin_after_leave = true

    # Similar to start_join but allows retrying a join if the first attempt fails. This is useful for cases
    # where we know the address will become available eventually. 
#   retry_join = []

    # The time to wait between join attempts. Defaults to 30s.
    retry_interval = "30s"

    # The maximum number of join attempts to be made before exiting with a return code of 1.
    # By default, this is set to 0 which is interpreted as infinite retries. 
    retry_max = 0

    # An array of strings specifying addresses of nodes to join upon startup. If Nomad is unable to join with any
    # of the specified addresses, agent startup will fail. By default, the agent won't join any nodes when it starts up. 
#   start_join = []
}

#----------------------- client-specific options ---------------------
client {
    # A boolean indicating if client mode is enabled. All other client configuration options depend on this value.
    # Defaults to false. 
    enabled = true

    # This is the state dir used to store client state. By default, it lives inside of the data_dir, in the
    # "client" sub-path. 
#   state_dir = "/tmp/client"

    # A directory used to store allocation data. Depending on the workload, the size of this directory can grow
    # arbitrarily large as it is used to store downloaded artifacts for drivers (QEMU images, JAR files, etc.). It is therefore
    # important to ensure this directory is placed some place on the filesystem with adequate storage capacity. By default, this
    # directory lives under the data_dir at the "alloc" sub-path. 
#   alloc_dir = "/tmp/alloc"

    # An array of server addresses. This list is used to register the client with the server nodes and advertise
    # the available resources so that the agent can receive work. 
    servers = ["127.0.0.1:4647"]

    # This is the value used to uniquely identify the local agent's node registration with the servers. This can be any arbitrary
    # string but must be unique to the cluster. By default, if not specified, a randomly- generate UUID will be used. 
#   node_id = "foo"

    # A string used to logically group client nodes by class. This can be used during job placement as a filter.
    # This option is not required and has no default. 
    node_class = "experimentation"

    # This is a key/value mapping of metadata pairs. This is a free-form map and can contain any string values. 
    meta {}

    # This is a key/value mapping of internal configuration for clients, such as for driver configuration. 
    options {}
    
    # This is a string to force network fingerprinting to use a specific network interface 
#   network_interface = "eth0"

    # This is an int that sets the default link speed of network interfaces, in megabits, if their speed can not be
    #  determined dynamically. 
    network_speed = 100
}
