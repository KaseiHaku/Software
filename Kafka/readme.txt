topic = partition + partition + ...
partition = record + record + ...
event/record/message =　key + value + timestamp

replication: 一个 partition 的副本，可以在创建 topic 时，指定 副本 的数量

offset: partition 中每个 record 都会分配一个唯一的序号，这个序号就是 offset
Consumer Group: 


每一个 record 在当前 partition 都有一个唯一递增的序列号，但是不能跨分区，所以在 topic 层面 record 是 无序 的
多个 client 消费同一个 topic 时，队列中的实际 record 不会被删除，仅仅是修改该 client 在队列中的 offset，
每一个 client 都有独立的 offset 互不影响


副本 replication:
    每个 Partition 的副本都包括一个 Leader 副本和多个 Follower 副本，
    Leader 由所有的副本共同选举得出，其他副本则都为 Follower 副本。
    在生产者写或者消费者读的时候，都只会与 Leader 打交道，在写入数据后 Follower 就会来拉取数据进行数据同步。


写入 partition:
    1. 指定 partition key，并进行 hash 计算，决定写入哪个 partition
    2. kafka 通过轮询的方式写入 partition
    3. Producer 可以通过自己规则，指定写入哪个  partition
    
读取 partition:
    1. Consumer 必须自己从 Topic 的 Partition 拉取消息。一个 Consumer 连接到一个 Broker 的 Partition，从中依次读取消息。
    2. 消息的 Offset 就是 Consumer 的游标，根据 Offset 来记录消息的消费情况。
       读完一条消息之后，Consumer 会推进到 Partition 中的下一个 Offset，继续读取消息。
       Offset 的推进和记录都是 Consumer 的责任，Kafka 是不管的。
    3. Kafka 中有一个 Consumer Group（消费组）的概念，多个 Consumer 组团去消费一个 Topic。
       同组的 Consumer 有相同的 Group ID。
       Consumer Group 机制会保障一条消息只被组内唯一一个 Consumer 消费，不会重复消费。
       消费组这种方式可以让多个 Partition 并行消费，大大提高了消息的消费能力，最大并行度为 Topic 的 Partition 数量。
       如果 Consumer>Partition, 那么多余的 Consumer 就处于空闲状态，直到有 工作中的 Consumer 挂掉，才会自动顶替
       同一个分区(partition)同时只能被一个消费者(consumer)实例消费
       
