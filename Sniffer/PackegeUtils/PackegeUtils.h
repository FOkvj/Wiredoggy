//
//  PackegeUtils.h
//  Sniffer
//
//  Created by DZC on 2022/4/4.
//

#import <Foundation/Foundation.h>
#import "pcap.h"
#include <netinet/in.h>
#include <net/ethernet.h>
#include <netinet/tcp.h>
#include <netinet/udp.h>
#include <netinet/ip_icmp.h>
#import <net/if_arp.h>
#import <netinet/if_ether.h>
#import <netinet/ip6.h>
#import <netinet/ip_icmp.h>

#import "EthernetHeader.h"
#import "IPHeader.h"
#import "TcpHeader.h"
#import "UDPHeader.h"
#import "ARPHeader.h"
#import "IPv6Header.h"
#import "ICMPHeader.h"
#import "HttpHeader.h"
static NSString* format_mac_string(unsigned char *mac_string) {
    return [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02", *(mac_string+0),*(mac_string+1),*(mac_string+2),*(mac_string+3),*(mac_string+4),*(mac_string+5)];
}


/**
 EtherNet
 */
static EthernetHeader* packEthernetHeader(const u_char *pkt_data) {

    struct ether_header *eth_header;
    EthernetHeader* ethernetHeader = [EthernetHeader new];
    eth_header = (struct ether_header *)pkt_data;
    
    unsigned char *p_mac_string = (unsigned char *)eth_header->ether_shost;
    ethernetHeader.sourceMac = format_mac_string(p_mac_string);
    p_mac_string = (unsigned char *)eth_header->ether_dhost;
    ethernetHeader.destMac = format_mac_string(p_mac_string);
    u_short ether_type = eth_header->ether_type;
    //判断mac帧头部类型字段
    switch (ntohs(ether_type)) {
        case ETHERTYPE_IP:
            ethernetHeader.type = @"IPv4";
            break;
        case ETHERTYPE_ARP:
            ethernetHeader.type = @"ARP";
            break;
        case ETHERTYPE_IPV6:
            ethernetHeader.type = @"IPv6";
        default:
            break;
    }
    return ethernetHeader;
}

/**
 ARP
 */
static ARPHeader* packARPHeader(const u_char *pkt_data){
    struct ether_arp* arp_hd = (struct ether_arp*)pkt_data;
    ARPHeader* arpHeader = [ARPHeader new];
    unsigned char *mac_string = (unsigned char *)arp_hd->arp_sha;
    arpHeader.sendHardWareAddr = format_mac_string(mac_string);
    mac_string = (unsigned char *)arp_hd->arp_spa;
    arpHeader.sendIpAddr = format_mac_string(mac_string);
    mac_string = (unsigned char *)arp_hd->arp_tha;
    arpHeader.targetHardWareAddr = format_mac_string(mac_string);
    mac_string = (unsigned char *)arp_hd->arp_tpa;
    arpHeader.targetIpAdrr = format_mac_string(mac_string);
    arpHeader.optionCode = ntohs(arp_hd->ea_hdr.ar_op);
    arpHeader.hardWareSize = arp_hd->ea_hdr.ar_hln;
    NSInteger pro = ntohs(arp_hd->ea_hdr.ar_pro);
    switch (pro) {
        case IPPROTO_IPV4:
            arpHeader.protocolType = @"IPv4";
            break;
        case IPPROTO_IPV6:
            arpHeader.protocolType = @"IPv6";
            break;
        default:
            arpHeader.protocolType = @"IPv4";
            break;
    }
    return arpHeader;
}
/**
 packIpHeader
 */
static IPHeader* packIPHeader(const u_char *pkt_data){
    struct ip* ip_hd = (struct ip*)pkt_data;
    //封装ip头方便展示
    IPHeader* ipHeader = [IPHeader new];
    NSString* src_ip = [NSString stringWithUTF8String: inet_ntoa(ip_hd->ip_src)];
    NSString* dst_ip = [NSString stringWithUTF8String: inet_ntoa(ip_hd->ip_dst)];
    ipHeader.identy = ntohs(ip_hd->ip_id);
    ipHeader.sourceIP = src_ip;
    ipHeader.destIP = dst_ip;
    ipHeader.headerCheckSum = ntohs(ip_hd->ip_sum);
    ipHeader.version = ip_hd->ip_v;
    ipHeader.timeToLive = ip_hd->ip_ttl;
    ipHeader.headerLen = ip_hd->ip_hl;
    ipHeader.totalLen = ip_hd->ip_len;
    ipHeader.offset = ntohs(ip_hd->ip_off);
    NSInteger srvType = ip_hd->ip_tos;
    //判断服务类型
    switch (srvType) {
        case IPTOS_ECN_CE:
            ipHeader.serviceType = @"ECN_CE";
            break;
        case IPTOS_DSCP_SHIFT:
            ipHeader.serviceType = @"DSCP_SHIFT";
        default:
            break;
    }
    
    NSInteger p = ip_hd->ip_p;
    //判断协议类型
    switch (p) {
        case IPPROTO_TCP:
            ipHeader.protocol = @"TCP";
            break;
        case IPPROTO_UDP:
            ipHeader.protocol = @"UDP";
            break;
        case IPPROTO_ICMP:
            ipHeader.protocol = @"ICMP";
        default:
            break;
    }
    return ipHeader;
}

/**
 packIPv6
 */
static IPv6Header* packIPv6Header(const u_char *pkt_data){
    struct hostent *hp;
    IPv6Header* ipv6Header = [IPv6Header new];
    struct ip6_hdr* ip6_hd = (struct ip6_hdr*)pkt_data;
    char str[INET6_ADDRSTRLEN];
    inet_ntop(AF_INET6, &ip6_hd->ip6_src, str, INET6_ADDRSTRLEN);
    ipv6Header.srcAddr = [NSString stringWithUTF8String:str];
    inet_ntop(AF_INET6, &ip6_hd->ip6_dst, str, INET6_ADDRSTRLEN);
    ipv6Header.dstAddr = [NSString stringWithUTF8String:str];
    ipv6Header.hopLimit = ip6_hd->ip6_ctlun.ip6_un1.ip6_un1_hlim;
    int next = ip6_hd->ip6_ctlun.ip6_un1.ip6_un1_nxt;
    switch (next) {
        case IPPROTO_UDP:
            ipv6Header.nextHeader = @"UDP";
            break;
        case IPPROTO_TCP:
            ipv6Header.nextHeader = @"TCP";
            break;
        case IPPROTO_ICMP:
            ipv6Header.nextHeader = @"ICMP";
            break;
        default:
            break;
    }
    ipv6Header.payloadLen = ip6_hd->ip6_ctlun.ip6_un1.ip6_un1_plen;
    ipv6Header.flowLable = ip6_hd->ip6_ctlun.ip6_un1.ip6_un1_flow;
    return ipv6Header;
}
/**
 TCP
 */
static TcpHeader* packTcpHeader(const u_char *pkt){
    const u_char *pkt_data = pkt;
    TcpHeader* tcpHeader = [TcpHeader new];
    struct tcphdr* tcp_hd = (struct tcphdr*)pkt_data;
    tcpHeader.sourcePort = ntohs(tcp_hd->th_sport);
    tcpHeader.destPort = ntohs(tcp_hd->th_dport);
    tcpHeader.seq = ntohs(tcp_hd->th_seq);
    tcpHeader.Ack = ntohs(tcp_hd->th_ack);
    tcpHeader.urgentPointer = ntohs(tcp_hd->th_urp);
    tcpHeader.offset = tcp_hd->th_off;
    tcpHeader.winSize = ntohs(tcp_hd->th_win);
    tcpHeader.flags = tcp_hd->th_flags;
    tcpHeader.flag_ACK = (tcp_hd->th_flags & 0x10) / 0x10;
    tcpHeader.flag_SYN = (tcp_hd->th_flags & 0x02) / 0x02;
    tcpHeader.flag_FIN = (tcp_hd->th_flags & 0x01) / 0x01;
    
    //get timestamp offset单位4字节 tcp头定长部分20字节
    if (tcpHeader.offset*4 > 20) {
        pkt_data += 20;
//        NSString* optstr = [NSString stringWithFormat:@"%d", pkt_data];
        
        NSInteger kind = pkt_data[0];//取option的kind字段
        pkt_data += 2;//跳过option的length字段
        unsigned int* info = (unsigned int*)pkt_data;
        //info字段前32bit是TSval，接着32bit是TSecr
        if (kind == TCPOPT_TIMESTAMP) {
            tcpHeader.option = [TCPTimeStampOption new];
            tcpHeader.option.TSval = info[0];
            tcpHeader.option.TSecr = info[1];
        }
    }
    return tcpHeader;
}

/**
 Http
 */
static HttpHeader* packHttpHeader(const u_char *pkt_data) {
    HttpHeader* httpHeader = [HttpHeader new];
    return httpHeader;
}
static UDPHeader* packUDPHeader(const u_char *pkt_data) {
    UDPHeader* udpHeader = [UDPHeader new];
    struct udphdr* udp_hd = (struct udphdr*)pkt_data;
    udpHeader.destPort = ntohs(udp_hd->uh_dport);
    udpHeader.sourcePort = ntohs(udp_hd->uh_sport);
    udpHeader.length = ntohs(udp_hd->uh_ulen);
    udpHeader.checkSum = ntohs(udp_hd->uh_sum);
    return udpHeader;
}

static ICMPHeader* packICMPHeader(const u_char *pkt_data) {
    ICMPHeader* icmpHeader = [ICMPHeader new];
    struct icmp* icmp = (struct icmp*)pkt_data;
    icmpHeader.code = icmp->icmp_code;
    icmpHeader.type = icmp->icmp_type;
    icmpHeader.checkSum = ntohs(icmp->icmp_cksum);
    icmpHeader.idBE = icmp->icmp_hun.ih_idseq.icd_id;
    icmpHeader.idLE = ntohs(icmp->icmp_hun.ih_idseq.icd_id);
    icmpHeader.seqNumBE = ntohs(icmp->icmp_hun.ih_idseq.icd_seq);
    icmpHeader.seqNumLE = ntohs(icmp->icmp_hun.ih_idseq.icd_seq);
    return icmpHeader;
}

static int get_link_header_len(pcap_t* handle)
{
    int linktype;
 
    // Determine the datalink layer type.
    if ((linktype = pcap_datalink(handle)) == PCAP_ERROR) {
        printf("pcap_datalink(): %s\n", pcap_geterr(handle));
        return 0;
    }
 
    // Set the datalink layer header size.
    switch (linktype)
    {
        case DLT_NULL:
            return 4;
            break;
     
        case DLT_EN10MB:
            return 14;
            break;
     
        case DLT_SLIP:
        case DLT_PPP:
            return 24;
            break;
     
        default:
            return 0;
    }
}
