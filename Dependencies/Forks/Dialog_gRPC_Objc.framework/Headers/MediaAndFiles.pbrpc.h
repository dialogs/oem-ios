// Code generated by gRPC proto compiler.  DO NOT EDIT!
// source: media_and_files.proto

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "MediaAndFiles.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class RequestCommitFileUpload;
@class RequestGetFileUploadPartUrl;
@class RequestGetFileUploadUrl;
@class RequestGetFileUrl;
@class RequestGetFileUrlBuilder;
@class RequestGetFileUrls;
@class ResponseCommitFileUpload;
@class ResponseGetFileUploadPartUrl;
@class ResponseGetFileUploadUrl;
@class ResponseGetFileUrl;
@class ResponseGetFileUrlBuilder;
@class ResponseGetFileUrls;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  #import "Wrappers.pbobjc.h"
  #import "Annotations.pbobjc.h"
  #import "Definitions.pbobjc.h"
  #import "Scalapb.pbobjc.h"
#endif

@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;
@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol MediaAndFiles2 <NSObject>

#pragma mark GetFileUrl(RequestGetFileUrl) returns (ResponseGetFileUrl)

/**
 * / Get link to file for downloading
 */
- (GRPCUnaryProtoCall *)getFileUrlWithMessage:(RequestGetFileUrl *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetFileUrls(RequestGetFileUrls) returns (ResponseGetFileUrls)

/**
 * / Get link to files for downloading
 */
- (GRPCUnaryProtoCall *)getFileUrlsWithMessage:(RequestGetFileUrls *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetFileUrlBuilder(RequestGetFileUrlBuilder) returns (ResponseGetFileUrlBuilder)

/**
 * / Create builder for file url
 */
- (GRPCUnaryProtoCall *)getFileUrlBuilderWithMessage:(RequestGetFileUrlBuilder *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetFileUploadUrl(RequestGetFileUploadUrl) returns (ResponseGetFileUploadUrl)

/**
 * / Get url for uploading
 */
- (GRPCUnaryProtoCall *)getFileUploadUrlWithMessage:(RequestGetFileUploadUrl *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CommitFileUpload(RequestCommitFileUpload) returns (ResponseCommitFileUpload)

/**
 * / Finish uploading a file
 */
- (GRPCUnaryProtoCall *)commitFileUploadWithMessage:(RequestCommitFileUpload *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetFileUploadPartUrl(RequestGetFileUploadPartUrl) returns (ResponseGetFileUploadPartUrl)

/**
 * / Get url for uploading chunk of file
 */
- (GRPCUnaryProtoCall *)getFileUploadPartUrlWithMessage:(RequestGetFileUploadPartUrl *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol MediaAndFiles <NSObject>

#pragma mark GetFileUrl(RequestGetFileUrl) returns (ResponseGetFileUrl)

/**
 * / Get link to file for downloading
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getFileUrlWithRequest:(RequestGetFileUrl *)request handler:(void(^)(ResponseGetFileUrl *_Nullable response, NSError *_Nullable error))handler;

/**
 * / Get link to file for downloading
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetFileUrlWithRequest:(RequestGetFileUrl *)request handler:(void(^)(ResponseGetFileUrl *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetFileUrls(RequestGetFileUrls) returns (ResponseGetFileUrls)

/**
 * / Get link to files for downloading
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getFileUrlsWithRequest:(RequestGetFileUrls *)request handler:(void(^)(ResponseGetFileUrls *_Nullable response, NSError *_Nullable error))handler;

/**
 * / Get link to files for downloading
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetFileUrlsWithRequest:(RequestGetFileUrls *)request handler:(void(^)(ResponseGetFileUrls *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetFileUrlBuilder(RequestGetFileUrlBuilder) returns (ResponseGetFileUrlBuilder)

/**
 * / Create builder for file url
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getFileUrlBuilderWithRequest:(RequestGetFileUrlBuilder *)request handler:(void(^)(ResponseGetFileUrlBuilder *_Nullable response, NSError *_Nullable error))handler;

/**
 * / Create builder for file url
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetFileUrlBuilderWithRequest:(RequestGetFileUrlBuilder *)request handler:(void(^)(ResponseGetFileUrlBuilder *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetFileUploadUrl(RequestGetFileUploadUrl) returns (ResponseGetFileUploadUrl)

/**
 * / Get url for uploading
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getFileUploadUrlWithRequest:(RequestGetFileUploadUrl *)request handler:(void(^)(ResponseGetFileUploadUrl *_Nullable response, NSError *_Nullable error))handler;

/**
 * / Get url for uploading
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetFileUploadUrlWithRequest:(RequestGetFileUploadUrl *)request handler:(void(^)(ResponseGetFileUploadUrl *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CommitFileUpload(RequestCommitFileUpload) returns (ResponseCommitFileUpload)

/**
 * / Finish uploading a file
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)commitFileUploadWithRequest:(RequestCommitFileUpload *)request handler:(void(^)(ResponseCommitFileUpload *_Nullable response, NSError *_Nullable error))handler;

/**
 * / Finish uploading a file
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCommitFileUploadWithRequest:(RequestCommitFileUpload *)request handler:(void(^)(ResponseCommitFileUpload *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetFileUploadPartUrl(RequestGetFileUploadPartUrl) returns (ResponseGetFileUploadPartUrl)

/**
 * / Get url for uploading chunk of file
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getFileUploadPartUrlWithRequest:(RequestGetFileUploadPartUrl *)request handler:(void(^)(ResponseGetFileUploadPartUrl *_Nullable response, NSError *_Nullable error))handler;

/**
 * / Get url for uploading chunk of file
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetFileUploadPartUrlWithRequest:(RequestGetFileUploadPartUrl *)request handler:(void(^)(ResponseGetFileUploadPartUrl *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface MediaAndFiles : GRPCProtoService<MediaAndFiles2, MediaAndFiles>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

