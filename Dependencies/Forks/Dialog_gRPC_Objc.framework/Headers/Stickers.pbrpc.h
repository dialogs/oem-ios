// Code generated by gRPC proto compiler.  DO NOT EDIT!
// source: stickers.proto

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "Stickers.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class RequestAddStickerCollection;
@class RequestAddStickerPackReference;
@class RequestLoadAcesssibleStickers;
@class RequestLoadOwnStickers;
@class RequestLoadStickerCollection;
@class RequestRemoveStickerCollection;
@class RequestRemoveStickerPackReference;
@class ResponseLoadAcesssibleStickers;
@class ResponseLoadOwnStickers;
@class ResponseLoadStickerCollection;
@class ResponseSeq;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  #import "Wrappers.pbobjc.h"
  #import "Annotations.pbobjc.h"
  #import "Definitions.pbobjc.h"
  #import "Miscellaneous.pbobjc.h"
  #import "MediaAndFiles.pbobjc.h"
  #import "Scalapb.pbobjc.h"
#endif

@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;
@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol Stickers2 <NSObject>

#pragma mark LoadOwnStickers(RequestLoadOwnStickers) returns (ResponseLoadOwnStickers)

- (GRPCUnaryProtoCall *)loadOwnStickersWithMessage:(RequestLoadOwnStickers *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark LoadAcesssibleStickers(RequestLoadAcesssibleStickers) returns (ResponseLoadAcesssibleStickers)

- (GRPCUnaryProtoCall *)loadAcesssibleStickersWithMessage:(RequestLoadAcesssibleStickers *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddStickerPackReference(RequestAddStickerPackReference) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)addStickerPackReferenceWithMessage:(RequestAddStickerPackReference *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveStickerPackReference(RequestRemoveStickerPackReference) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)removeStickerPackReferenceWithMessage:(RequestRemoveStickerPackReference *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddStickerCollection(RequestAddStickerCollection) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)addStickerCollectionWithMessage:(RequestAddStickerCollection *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveStickerCollection(RequestRemoveStickerCollection) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)removeStickerCollectionWithMessage:(RequestRemoveStickerCollection *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark LoadStickerCollection(RequestLoadStickerCollection) returns (ResponseLoadStickerCollection)

- (GRPCUnaryProtoCall *)loadStickerCollectionWithMessage:(RequestLoadStickerCollection *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol Stickers <NSObject>

#pragma mark LoadOwnStickers(RequestLoadOwnStickers) returns (ResponseLoadOwnStickers)

- (void)loadOwnStickersWithRequest:(RequestLoadOwnStickers *)request handler:(void(^)(ResponseLoadOwnStickers *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLoadOwnStickersWithRequest:(RequestLoadOwnStickers *)request handler:(void(^)(ResponseLoadOwnStickers *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LoadAcesssibleStickers(RequestLoadAcesssibleStickers) returns (ResponseLoadAcesssibleStickers)

- (void)loadAcesssibleStickersWithRequest:(RequestLoadAcesssibleStickers *)request handler:(void(^)(ResponseLoadAcesssibleStickers *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLoadAcesssibleStickersWithRequest:(RequestLoadAcesssibleStickers *)request handler:(void(^)(ResponseLoadAcesssibleStickers *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddStickerPackReference(RequestAddStickerPackReference) returns (ResponseSeq)

- (void)addStickerPackReferenceWithRequest:(RequestAddStickerPackReference *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddStickerPackReferenceWithRequest:(RequestAddStickerPackReference *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RemoveStickerPackReference(RequestRemoveStickerPackReference) returns (ResponseSeq)

- (void)removeStickerPackReferenceWithRequest:(RequestRemoveStickerPackReference *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveStickerPackReferenceWithRequest:(RequestRemoveStickerPackReference *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddStickerCollection(RequestAddStickerCollection) returns (ResponseSeq)

- (void)addStickerCollectionWithRequest:(RequestAddStickerCollection *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddStickerCollectionWithRequest:(RequestAddStickerCollection *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RemoveStickerCollection(RequestRemoveStickerCollection) returns (ResponseSeq)

- (void)removeStickerCollectionWithRequest:(RequestRemoveStickerCollection *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveStickerCollectionWithRequest:(RequestRemoveStickerCollection *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LoadStickerCollection(RequestLoadStickerCollection) returns (ResponseLoadStickerCollection)

- (void)loadStickerCollectionWithRequest:(RequestLoadStickerCollection *)request handler:(void(^)(ResponseLoadStickerCollection *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLoadStickerCollectionWithRequest:(RequestLoadStickerCollection *)request handler:(void(^)(ResponseLoadStickerCollection *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Stickers : GRPCProtoService<Stickers2, Stickers>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

