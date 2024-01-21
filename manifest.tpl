apiVersion: v1
kind: Namespace
metadata:
  name: __NAMESPACE_NAME__
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: __DEPLOYMENT_NAME__-pvc
  namespace: __NAMESPACE_NAME__
spec:
  resources:
    requests:
      storage: __STORAGE_SIZE__
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: __DEPLOYMENT_NAME__
  namespace: __NAMESPACE_NAME__
  labels:
    app: __DEPLOYMENT_NAME__
spec:
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  selector:
    matchLabels:
      app: __DEPLOYMENT_NAME__
  template:
    metadata:
      labels:
        app: __DEPLOYMENT_NAME__
    spec:
      restartPolicy: Always
      containers:
      - image: thijsvanloef/palworld-server-docker
        imagePullPolicy: Always
        name: palworld
        resources:
          requests:
            cpu: "4000m"
            memory: "4Gi"
          limits:
            cpu: "4000m"
            memory: "4Gi"
        # livenessProbe:
        #   httpGet:
        #     path: /_status/healthz
        #     port: 5000
        #   initialDelaySeconds: 90
        #   timeoutSeconds: 10
        # readinessProbe:
        #   httpGet:
        #     path: /_status/healthz
        #     port: 5000
        #   initialDelaySeconds: 30
        #   timeoutSeconds: 10
        env:
        - name: PORT
          value: "8211"
        - name: PLAYERS
          value: "31" # 1-31
        - name: MULTITHREADING
          value: "true"
        - name: COMMUNITY
          value: "true"
        - name: SERVER_NAME
          value: "__SERVER_NAME__"
        - name: SERVER_PASSWORD
          value: "__SERVER_PASSWORD__"
        - name: ADMIN_PASSWORD
          value: "__ADMIN_PASSWORD__"
        - name: UPDATE_ON_BOOT
          value: "true"
        ports:
        - containerPort: 27015
          name: query
          protocol: UDP
        - containerPort: 8211
          name: game
          protocol: UDP
        volumeMounts:
        - mountPath: /palworld
          name: data
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: __DEPLOYMENT_NAME__-pvc
---
kind: Service
apiVersion: v1
metadata:
  name: __DEPLOYMENT_NAME__-svc
  namespace: __NAMESPACE_NAME__
spec:
  selector:
    app: __DEPLOYMENT_NAME__
  type: LoadBalancer
  ports:
  - name: game
    port: 8211
    targetPort: 8211
    protocol: UDP
  - name: query
    port: 27015
    targetPort: 27015
    protocol: UDP
