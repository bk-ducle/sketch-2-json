# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# No registry-verified custom nodes or resolvable GitHub aux_id were provided in the workflow's customNodes.
# The following unknown_registry nodes could not be resolved because no aux_id (GitHub repo) or registry id was provided:
# - FluxKontextImageScale
# - VAEEncode
# - DualCLIPLoader
# - CLIPTextEncode
# - EmptyLatentImage
# - VAEDecode
# - FluxGuidance
# - CLIPTextEncode
# - ReferenceLatent
# - KSampler
# - LoadImage
# - UNETLoader
# - VAELoader
# - SaveImage

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/stable-diffusion-3.5-fp8/resolve/main/text_encoders/clip_l.safetensors --relative-path models/text_encoders --filename clip_l.safetensors
RUN comfy model download --url https://huggingface.co/comfyanonymous/flux_text_encoders/blob/main/t5xxl_fp16.safetensors --relative-path models/text_encoders --filename t5xxl_fp16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/flux1-kontext-dev_ComfyUI/blob/main/split_files/diffusion_models/flux1-dev-kontext_fp8_scaled.safetensors --relative-path models/diffusion_models --filename flux1-dev-kontext_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/blob/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
